import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';

class DeleteUser {
  final AuthRepository authRepository;

  DeleteUser(this.authRepository);

  Future<Either<Failure, String>> execute() {
    return authRepository.deleteUser();
  }
}
