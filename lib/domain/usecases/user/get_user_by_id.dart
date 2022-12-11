import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';

class GetUserById {
  final AuthRepository authRepository;

  GetUserById(this.authRepository);

  Future<Either<Failure, User>> execute(String uuid) {
    return authRepository.getUserById(uuid);
  }
}
