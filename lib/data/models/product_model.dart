import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.uuid,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.ratting,
    required this.stock,
    required this.weight,
    required this.category,
    required this.image,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String uuid;
  final String title;
  final String description;
  final int price;
  final double? discount;
  final double ratting;
  final int stock;
  final String weight;
  final String category;
  final String image;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        // quantity: 0,
        uuid: json["uuid"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discount: json["discount"].toDouble(),
        ratting: json["ratting"].toDouble(),
        stock: json["stock"],
        weight: json["weight"],
        category: json["category"],
        image: json["image"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "title": title,
        "description": description,
        "price": price,
        "discount": discount,
        "ratting": ratting,
        "stock": stock,
        "weight": weight,
        "category": category,
        "image": image,
        "image_url": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  Product toEntity() {
    return Product(
      id: id,
      uuid: uuid,
      quantity: 0,
      title: title,
      description: description,
      price: price,
      discount: discount!,
      ratting: ratting,
      stock: stock,
      weight: weight,
      category: category,
      image: image,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        title,
        description,
        price,
        discount,
        ratting,
        stock,
        weight,
        category,
        image,
        imageUrl,
        createdAt,
        updatedAt,
      ];
}
