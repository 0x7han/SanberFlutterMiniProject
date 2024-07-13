part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class LoadingCartState extends CartState {}

final class LoadedCartState extends CartState {
  final List<Cart> carts;
  const LoadedCartState(this.carts);
  @override
  List<Object> get props => [carts];
}

final class CartErrorState extends CartState {
  final String message;
  const CartErrorState(this.message);
  @override
  List<Object> get props => [message];
}

final class LoadingProductState extends CartState {}

final class LoadedProductState extends CartState {
  final Product product;
  const LoadedProductState(this.product);
  @override
  List<Object> get props => [product];
}

final class ProductErrorState extends CartState {
  final String message;
  const ProductErrorState(this.message);
  @override
  List<Object> get props => [message];
}


