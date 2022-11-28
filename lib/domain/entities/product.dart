import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
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
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String uuid;
  final String title;
  final String description;
  final int price;
  final double discount;
  final double ratting;
  final int stock;
  final int weight;
  final String category;
  final String image;
  final String imageUrl;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
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
        userId,
        createdAt,
        updatedAt,
      ];
}
