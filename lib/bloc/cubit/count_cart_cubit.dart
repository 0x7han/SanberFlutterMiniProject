import 'package:bloc/bloc.dart';
import 'package:sanber_flutter_mini_project_1/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'count_cart_state.dart';

class CountCartCubit extends Cubit<CountCartState> {
  final CartRepository _cartRepository = CartRepository();

  CountCartCubit() : super(CountCartInitial());

  void displayTotalQuantity(int userId) async {
    try {
      final carts = await _cartRepository.getCartsByUserId(userId);
      final totalQuantity = carts.fold<int>(
          0,
          (sum, cart) =>
              sum +
              cart.products.fold<int>(
                  0, (prodSum, product) => prodSum + product.quantity));
      emit(TotalQuantityLoaded(totalQuantity));
    } catch (e) {
      emit(TotalQuantityError(e.toString()));
    }
  }
}
