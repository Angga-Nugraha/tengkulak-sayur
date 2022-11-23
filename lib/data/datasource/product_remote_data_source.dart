import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tengkulak_sayur/data/models/product_model.dart';
import 'package:tengkulak_sayur/data/models/product_response.dart';

import '../utils/exception.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> searchProduct(String query);
  Future<List<ProductModel>> getCategoryProduct(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  static const _baseUrl = "https://dummyjson.com";
  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse('$_baseUrl/products'));
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).productList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> searchProduct(String query) async {
    final response =
        await client.get(Uri.parse('$_baseUrl/products/search?q=$query'));
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).productList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getCategoryProduct(String query) async {
    final response =
        await client.get(Uri.parse('$_baseUrl/products/category/$query'));
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).productList;
    } else {
      throw ServerException();
    }
  }
}
