import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tengkulak_sayur/data/models/user_model.dart';
import 'package:tengkulak_sayur/data/utils/exception.dart';

abstract class Authentication {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String name, String email, String password,
      String confPassword, String addres);
  Future<UserModel> me(int id);
}

class AuthenticationImpl implements Authentication {
  static const _baseUrl = "http://10.0.2.2:5000";
  final http.Client client;

  AuthenticationImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await client.post(Uri.parse('$_baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}));

    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      sharedPreferences.setString("token", data['data']['refresh_token']);
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
    final response = await client.post(Uri.parse('$_baseUrl/register'),
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
  Future<UserModel> me(int id) async {
    final response = await client.post(Uri.parse('$_baseUrl/users/$id'));

    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));
    print(data);
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
}
