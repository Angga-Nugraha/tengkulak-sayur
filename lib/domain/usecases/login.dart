import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/repositories/auth_repository.dart';

import '../../data/utils/failure.dart';

class Login {
  final AuthRepository authRepository;

  Login(this.authRepository);

  Future<Either<Failure, User>> execute(String email, String password) {
    return authRepository.login(email, password);
  }
}
