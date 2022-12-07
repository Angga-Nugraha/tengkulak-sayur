import 'package:equatable/equatable.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';

class ProductCart extends Equatable {
  final int id;
  final String title;
  final String image;
  final int price;
  final int quantity;

  const ProductCart({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory ProductCart.fromEntity(Product product) => ProductCart(
        id: product.id,
        title: product.title,
        image: product.image,
        price: product.price,
        quantity: product.quantity,
      );
  factory ProductCart.fromMap(Map<String, dynamic> map) => ProductCart(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        price: map['price'],
        quantity: map['quantity'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'price': price,
        'quantity': quantity,
      };

  Product toEntity() => Product.cartList(
        id: id,
        title: title,
        image: image,
        price: price,
        quantity: quantity,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        price,
        quantity,
      ];
}
