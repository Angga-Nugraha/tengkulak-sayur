import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tengkulak_sayur/data/database/sqflite/database_helper.dart';
import 'package:tengkulak_sayur/data/database/storageHelper/secure_storage_helper.dart';
import 'package:tengkulak_sayur/data/models/product_cart_model.dart';
import 'package:tengkulak_sayur/data/models/product_model.dart';
import 'package:tengkulak_sayur/data/models/product_response.dart';

import '../utils/exception.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> searchProduct(String query);
  Future<List<ProductModel>> getCategoryProduct(String query);
  Future<String> insertToCart(ProductCart product);
  Future<String> removeFromCart(ProductCart product);
  Future<List<ProductCart>> getListcart();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  static const _baseUrl = "http://10.0.2.2:5000";
  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final token = await secureStorage.readToken();
    final response = await client.get(Uri.parse('$_baseUrl/product'),
        headers: {'authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).productList;
    } else if (response.statusCode == 500) {
      throw 'Upps something wrong...';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> searchProduct(String query) async {
    final token = await secureStorage.readToken();
    final response = await client.get(
        Uri.parse('$_baseUrl/search/product?search=$query'),
        headers: {'authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).productList;
    } else if (response.statusCode == 500) {
      throw 'Upps something wrong...';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getCategoryProduct(String query) async {
    final token = await secureStorage.readToken();

    final response = await client.get(
        Uri.parse('$_baseUrl/product/category/$query'),
        headers: {'authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).productList;
    } else if (response.statusCode == 500) {
      throw 'Upps something wrong...';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductCart>> getListcart() async {
    final cart = await databaseHelper.getListCart();
    print(cart);
    return cart.map((e) => ProductCart.fromMap(e)).toList();
  }

  @override
  Future<String> insertToCart(ProductCart product) async {
    try {
      await databaseHelper.insertTocart(product);

      return 'Add to cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFromCart(ProductCart product) async {
    try {
      await databaseHelper.removeFromCart(product);
      return 'Remove from cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}