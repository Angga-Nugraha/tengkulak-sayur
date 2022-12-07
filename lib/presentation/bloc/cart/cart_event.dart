part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class InsertToCart extends CartEvent {
  final Product product;

  const InsertToCart({required this.product});

  @override
  List<Object?> get props => [product];
}

class AddedItemcart extends CartEvent {
  final Product product;

  const AddedItemcart({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveItemCart extends CartEvent {
  final Product product;

  const RemoveItemCart({required this.product});

  @override
  List<Object?> get props => [product];
}

class GetAllCart extends CartEvent {
  const GetAllCart();

  @override
  List<Object?> get props => [];
}
