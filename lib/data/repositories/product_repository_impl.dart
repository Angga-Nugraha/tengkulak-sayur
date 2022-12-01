import 'dart:io';

import 'package:tengkulak_sayur/data/utils/exception.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/data/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tengkulak_sayur/data/datasource/product_remote_data_source.dart';
import 'package:tengkulak_sayur/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});
  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await productRemoteDataSource.getAllProducts();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProduct(String query) async {
    try {
      final result = await productRemoteDataSource.searchProduct(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCategoryProduct(
      String query) async {
    try {
      final result = await productRemoteDataSource.getCategoryProduct(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
