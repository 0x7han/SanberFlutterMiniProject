part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class LoadCartByUserId extends CartEvent {
  final int userId;
  const LoadCartByUserId(this.userId);
  @override
  List<Object> get props => [userId];
}

final class LoadProductById extends CartEvent {
  final int productId;
  const LoadProductById(this.productId);
  @override
  List<Object> get props => [productId];
}

