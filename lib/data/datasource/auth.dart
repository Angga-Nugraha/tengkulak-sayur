import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:tengkulak_sayur/data/models/user_model.dart';
import 'package:tengkulak_sayur/data/utils/exception.dart';

abstract class Authentication {
  Future<UserModel> login(String email, String password);
}

class AuthenticationImpl implements Authentication {
  static const _baseUrl = "http://localhost:5000";
  final http.Client client;

  AuthenticationImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(Uri.parse('$_baseUrl/login'),
        body: json.encode({
          "email": email,
          "password": password,
        }));
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
