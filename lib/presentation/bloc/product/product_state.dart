part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  final String message;
  const ProductErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductHasDataState extends ProductState {
  final List<Product> result;
  const ProductHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}

class ProductIdHasDataState extends ProductState {
  final Product result;
  const ProductIdHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}
