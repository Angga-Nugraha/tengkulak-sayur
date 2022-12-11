import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product>> execute(int id) {
    return repository.getProductById(id);
  }
}
