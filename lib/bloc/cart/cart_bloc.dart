import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanber_flutter_mini_project_1/model/cart.dart';
import 'package:sanber_flutter_mini_project_1/model/product.dart';
import 'package:sanber_flutter_mini_project_1/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository = CartRepository();
  CartBloc() : super(LoadingCartState()) {
    on<LoadCartByUserId>((event, emit) async {
      try {
        final carts = await _cartRepository.getCartsByUserId(event.userId);
        emit(LoadedCartState(carts));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });

    on<LoadProductById>((event, emit) async {
      try {
        final product = await _cartRepository.getProductById(event.productId);
        emit(LoadedProductState(product));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
