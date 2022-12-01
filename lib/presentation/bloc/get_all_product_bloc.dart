import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_all_product.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  final GetAllProduct getAllProduct;

  GetAllProductBloc({required this.getAllProduct})
      : super(GetAllProductEmpty()) {
    on<FetchAllProduct>((event, emit) async {
      emit(GetAllProductLoading());
      final result = await getAllProduct.execute();
      result.fold(
        (failure) => emit(GetAllProductError(failure.message)),
        (data) => emit(GetAllProductHasData(result: data)),
      );
    });
  }
}

// event bloc
abstract class GetAllProductEvent extends Equatable {
  const GetAllProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllProduct extends GetAllProductEvent {}

// state bloc

abstract class GetAllProductState extends Equatable {
  const GetAllProductState();

  @override
  List<Object?> get props => [];
}

class GetAllProductEmpty extends GetAllProductState {}

class GetAllProductLoading extends GetAllProductState {}

class GetAllProductError extends GetAllProductState {
  final String message;
  const GetAllProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetAllProductHasData extends GetAllProductState {
  final List<Product> result;
  const GetAllProductHasData({required this.result});

  @override
  List<Object?> get props => [result];
}
