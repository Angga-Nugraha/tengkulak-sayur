import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Product>>> searchProduct(String query);
  Future<Either<Failure, List<Product>>> getCategoryProduct(String query);
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, String>> insertToCart(Product product);
  Future<Either<Failure, String>> removeFromCart(Product product);
  Future<Either<Failure, List<Product>>> getListCart();
}
