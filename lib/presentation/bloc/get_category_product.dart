// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengkulak_sayur/domain/entities/product.dart';
// import 'package:tengkulak_sayur/domain/usecases/get_product_category.dart';

// class CategoryProductBloc extends Bloc<CategoryEvent, CategoryState> {
//   final GetCategoryProduct getCategoryProduct;

//   CategoryProductBloc(this.getCategoryProduct) : super(CategoryEmpty()) {
//     on<FetchData>((event, emit) async {
//       final query = event.query;

//       emit(CategoryLoading());

//       final result = await getCategoryProduct.execute(query);
//       result.fold(
//         (failure) => emit(CategoryError(failure.message)),
//         (data) => emit(CategoryHasData(data)),
//       );
//     });
//   }
// }

// // Bloc Event
// abstract class CategoryEvent extends Equatable {
//   const CategoryEvent();

//   @override
//   List<Object?> get props => [];
// }

// class FetchData extends CategoryEvent {
//   final String query;

//   const FetchData(this.query);

//   @override
//   List<Object?> get props => [query];
// }

// // Bloc State

// abstract class CategoryState extends Equatable {
//   const CategoryState();

//   @override
//   List<Object?> get props => [];
// }

// class CategoryEmpty extends CategoryState {}

// class CategoryLoading extends CategoryState {}

// class CategoryError extends CategoryState {
//   final String message;
//   const CategoryError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class CategoryHasData extends CategoryState {
//   final List<Product> result;
//   const CategoryHasData(this.result);

//   @override
//   List<Object?> get props => [result];
// }
