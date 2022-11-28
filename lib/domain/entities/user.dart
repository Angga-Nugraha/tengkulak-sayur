import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
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

  @override
  List<Object?> get props => [
        id,
        uuid,
        name,
        email,
        addres,
      ];
}
