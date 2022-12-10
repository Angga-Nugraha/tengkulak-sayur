part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllProduct extends ProductEvent {}

class FetchIdProduct extends ProductEvent {
  final int id;

  const FetchIdProduct(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchCategoryProduct extends ProductEvent {
  final String query;

  const FetchCategoryProduct(this.query);

  @override
  List<Object?> get props => [query];
}

class OnQueryChanged extends ProductEvent {
  final String query;
  const OnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
