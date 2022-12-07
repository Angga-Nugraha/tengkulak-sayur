import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';

class GetListCart {
  ProductRepository productRepository;

  GetListCart(this.productRepository);

  Future<Either<Failure, List<Product>>> execute() {
    return productRepository.getListCart();
  }
}
