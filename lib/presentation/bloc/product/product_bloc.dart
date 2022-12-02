import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_all_product.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_product_category.dart';
import 'package:tengkulak_sayur/domain/usecases/product/search_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProduct getAllProduct;

  ProductBloc({required this.getAllProduct}) : super(ProductInitialState()) {
    on<FetchAllProduct>((event, emit) async {
      emit(ProductLoadingState());
      final result = await getAllProduct.execute();
      result.fold(
        (failure) => emit(ProductErrorState(failure.message)),
        (data) => emit(ProductHasDataState(result: data)),
      );
    });
  }
}

//============================================================================//
class CategoryProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetCategoryProduct getCategoryProduct;

  CategoryProductBloc({required this.getCategoryProduct})
      : super(ProductInitialState()) {
    on<FetchCategoryProduct>((event, emit) async {
      final query = event.query;
      final result = await getCategoryProduct.execute(query);
      result.fold(
        (failure) => emit(ProductErrorState(failure.message)),
        (data) => emit(ProductHasDataState(result: data)),
      );
    });
  }
}

//============================================================================//
class SearchProductBloc extends Bloc<ProductEvent, ProductState> {
  final SearchProduct searchProduct;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchProductBloc({required this.searchProduct})
      : super(ProductInitialState()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(ProductLoadingState());
      final result = await searchProduct.execute(query);
      result.fold(
        (failure) => emit(ProductErrorState(failure.message)),
        (data) => emit(ProductHasDataState(result: data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
