import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.image,
    required this.addres,
    required this.refreshToken,
  });

  final int id;
  final String? uuid;
  final String name;
  final String email;
  final String? image;
  final String addres;
  final String? refreshToken;

  @override
  List<Object?> get props => [
        id,
        uuid,
        name,
        email,
        image,
        addres,
        refreshToken,
      ];
}
