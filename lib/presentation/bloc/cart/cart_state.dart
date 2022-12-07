part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {}

class CartRemoveState extends CartState {}

class CartAddedState extends CartState {}

class CartSuccessState extends CartState {
  final String message;
  const CartSuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartErrorState extends CartState {
  final String message;
  const CartErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartHasData extends CartState {
  final List<Product> product;

  const CartHasData(this.product);

  @override
  List<Object> get props => [product];
}
