import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';

class EditUser {
  final AuthRepository authRepository;

  EditUser(this.authRepository);

  Future<Either<Failure, String>> execute(String name, String email,
      String password, String confPassword, String addres, File? image) {
    return authRepository.editUser(
      name,
      email,
      password,
      confPassword,
      addres,
      image,
    );
  }
}
