// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.addres,
  });

  final int id;
  final String uuid;
  final String name;
  final String email;
  final String addres;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        email: json["email"],
        addres: json["addres"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "email": email,
        "addres": addres,
      };

  User toEntity() {
    return User(
      id: id,
      uuid: uuid,
      name: name,
      email: email,
      addres: addres,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        name,
        email,
        addres,
      ];
}
