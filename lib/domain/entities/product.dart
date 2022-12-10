import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
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
    this.quantity = 0,
  });

  Product.cartList({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 0,
  });

  int quantity;
  final int id;
  String? uuid;
  final String title;
  String? description;
  final int price;
  double? discount;
  double? ratting;
  int? stock;
  String? weight;
  String? category;
  final String image;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

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
