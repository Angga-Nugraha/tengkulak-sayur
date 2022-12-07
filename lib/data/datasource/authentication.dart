import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:tengkulak_sayur/data/database/storageHelper/secure_storage_helper.dart';
import 'package:tengkulak_sayur/data/models/user_model.dart';
import 'package:tengkulak_sayur/data/utils/constant.dart';
import 'package:tengkulak_sayur/data/utils/exception.dart';

abstract class Authentication {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String name, String email, String password,
      String confPassword, String addres);
  Future<String?> logout();
  Future<UserModel> getUserById(String uuid);
  Future<String> deleteUser();
}

class AuthenticationImpl implements Authentication {
  final http.Client client;

  AuthenticationImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}));

    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      await secureStorage.persistenToken(data['data']['refresh_token']);
      await secureStorage.persistenId(data['data']['uuid']);

      return UserModel.fromJson(data['data']);
    } else if (response.statusCode == 400) {
      throw data['msg'];
    } else if (response.statusCode == 404) {
      throw data['msg'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signUp(String name, String email, String password,
      String confPassword, String addres) async {
    final response = await client.post(Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "name": name,
          "email": email,
          "password": password,
          "confPassword": confPassword,
          "addres": addres
        }));

    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      return UserModel.fromJson(data['data']);
    } else if (response.statusCode == 400) {
      throw data['msg'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String?> logout() async {
    final token = await secureStorage.readToken();
    final response = await client
        .delete(Uri.parse('$baseUrl/logout'), headers: {'cookie': '$token'});
    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));
    if (response.statusCode == 200) {
      await secureStorage.deleteSecureStorage();
      return data['msg'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserById(String uuid) async {
    final token = await secureStorage.readToken();
    final response = await client.get(Uri.parse('$baseUrl/users/$uuid'),
        headers: {'authorization': 'Bearer $token'});

    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      return UserModel.fromJson(data['data']);
    } else if (response.statusCode == 401) {
      throw data['msg'];
    } else if (response.statusCode == 404) {
      throw data['msg'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteUser() async {
    final token = await secureStorage.readToken();
    final uuid = await secureStorage.readId();
    final response = await client.delete(Uri.parse('$baseUrl/users/$uuid'),
        headers: {'authorization': 'Bearer $token'});
    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));
    if (response.statusCode == 200) {
      await secureStorage.deleteSecureStorage();
      return data['msg'];
    } else {
      throw ServerException();
    }
  }
}
