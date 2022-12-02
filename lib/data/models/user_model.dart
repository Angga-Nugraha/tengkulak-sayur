// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.image,
    required this.addres,
    required this.refreshToken,
  });

  final int id;
  final String uuid;
  final String name;
  final String email;
  final String? image;
  final String addres;
  final String? refreshToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        addres: json["addres"],
        refreshToken: json['refresh_token'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "email": email,
        "image": image ?? '',
        "addres": addres,
        "refresh_token": refreshToken ?? '',
      };

  User toEntity() {
    return User(
      id: id,
      uuid: uuid,
      name: name,
      email: email,
      image: image,
      addres: addres,
      refreshToken: refreshToken,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        name,
        email,
        addres,
        refreshToken,
      ];
}
