import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/common/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signUp(String name, String email,
      String password, String confPassword, String addres);
  Future<Either<Failure, String>> editUser(String name, String email,
      String password, String confPassword, String addres, File? image);
  Future<Either<Failure, String?>> logout();
  Future<Either<Failure, User>> getUserById(String uuid);
  Future<Either<Failure, String>> deleteUser();
}
