import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/common/utils/failure.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';

class Logout {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  Future<Either<Failure, String?>> execute() {
    return authRepository.logout();
  }
}
