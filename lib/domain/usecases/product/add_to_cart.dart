import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';

class AddToCart {
  final ProductRepository productRepository;

  AddToCart(this.productRepository);

  Future<Either<Failure, String>> execute(Product product) {
    return productRepository.insertToCart(product);
  }
}
