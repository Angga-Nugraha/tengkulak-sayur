import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/domain/usecases/product/add_to_cart.dart';
import 'package:tengkulak_sayur/domain/usecases/product/get_list_cart.dart';
import 'package:tengkulak_sayur/domain/usecases/product/remove_from_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final GetListCart getListCart;
  final RemoveFromCart removeFromCart;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  CartBloc(
      {required this.addToCart,
      required this.getListCart,
      required this.removeFromCart})
      : super(CartInitialState()) {
    on<InsertToCart>((event, emit) async {
      final product = event.product;

      final result = await addToCart.execute(product);
      result.fold(
        (failure) => emit(CartErrorState(message: failure.message)),
        (data) => emit(const CartSuccessState(message: 'Add to cart')),
      );
    });
    on<AddedItemcart>((event, emit) async {
      final product = event.product;

      final result = await addToCart.execute(product);
      result.fold(
        (failure) => emit(CartErrorState(message: failure.message)),
        (data) => emit(CartAddedState()),
      );
    });
    on<RemoveItemCart>((event, emit) async {
      final product = event.product;

      final result = await removeFromCart.execute(product);
      result.fold(
        (failure) => emit(CartErrorState(message: failure.message)),
        (data) => emit(CartRemoveState()),
      );
    });

    on<GetAllCart>((event, emit) async {
      final result = await getListCart.execute();
      result.fold(
        (failure) => emit(CartErrorState(message: failure.message)),
        (data) => emit(CartHasData(data)),
      );
    });
  }
}
