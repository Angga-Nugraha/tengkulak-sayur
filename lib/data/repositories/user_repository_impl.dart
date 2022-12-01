import 'dart:io';

import 'package:tengkulak_sayur/data/datasource/user_remote_data_source.dart';
import 'package:tengkulak_sayur/data/utils/exception.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';

class AuthRepositositoryImpl implements AuthRepository {
  final Authentication authentication;

  AuthRepositositoryImpl({required this.authentication});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final result = await authentication.login(email, password);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(String name, String email,
      String password, String confPassword, String addres) async {
    try {
      final result = await authentication.signUp(
          name, email, password, confPassword, addres);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> me(int id) async {
    try {
      final result = await authentication.me(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
