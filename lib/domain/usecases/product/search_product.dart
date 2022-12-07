import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/common/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';

class SearchProduct {
  final ProductRepository repository;

  SearchProduct(this.repository);

  Future<Either<Failure, List<Product>>> execute(String query) {
    return repository.searchProduct(query);
  }
}
