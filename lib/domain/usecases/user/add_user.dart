import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/common/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';

class SignUp {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  Future<Either<Failure, User>> execute(String name, String email,
      String password, String confPassword, String addres) {
    return authRepository.signUp(name, email, password, confPassword, addres);
  }
}
