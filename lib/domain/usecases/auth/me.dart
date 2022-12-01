import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/user.dart';
import 'package:tengkulak_sayur/domain/repositories/user_repository.dart';

class Me {
  final AuthRepository authRepository;

  Me(this.authRepository);

  Future<Either<Failure, User>> execute(int id) {
    return authRepository.me(id);
  }
}
