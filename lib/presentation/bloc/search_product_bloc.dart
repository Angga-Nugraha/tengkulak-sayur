import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/usecases/search_product.dart';

class SearchProductBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProduct searchProduct;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchProductBloc(this.searchProduct) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await searchProduct.execute(query);
      // print(result);
      result.fold(
        (failure) => emit(SearchError(failure.message)),
        (data) => emit(SearchHashData(data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

// Bloc Event
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class OnQueryChanged extends SearchEvent {
  final String query;
  const OnQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

// Bloc State
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchHashData extends SearchState {
  final List<Product> result;

  const SearchHashData(this.result);

  @override
  List<Object?> get props => [result];
}
