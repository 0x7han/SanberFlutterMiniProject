import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanber_flutter_mini_project_1/model/cart.dart';
import 'package:sanber_flutter_mini_project_1/model/user.dart';
import 'package:sanber_flutter_mini_project_1/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository = CartRepository();

  CartBloc() : super(CartInitial()) {
    on<LoadCartRecent>((event, emit) async {
      emit(CartLoading());
      try {
        final List<Cart> carts =
            await _cartRepository.getByUserId(event.userId);

        carts.sort((a, b) => b.date.compareTo(a.date));

        // cart bagde ngambil dari data terbaru
        // for (var cart in carts) {
        //   print(cart.date);
        //   for (var product in cart.products) {
        //     print(product['quantity']);
        //   }
        // }
        String mostRecentDate = carts.first.date;

        List<Cart> recentCarts =
            carts.where((cart) => cart.date == mostRecentDate).toList();

        num countRecent = recentCarts.fold(0, (sum, cart) {
          return sum +
              cart.products.fold(0, (productSum, product) {
                return productSum + product['quantity'];
              });
        });

        emit(CartRecentLoaded(count: countRecent.toInt(), date: mostRecentDate, userId: event.userId));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<LoadCartByDate>((event, emit) async {
      emit(CartLoading());
      try {
        final List<Cart> carts =
            await _cartRepository.getByUserId(event.userId);

        carts.sort((a, b) => b.date.compareTo(a.date));


        List<Cart> recentCarts =
            carts.where((cart) => cart.date == event.date).toList();


        emit(CartLoaded(carts: recentCarts, selectedDate: event.date));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
