part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartByDate extends CartEvent {
  final int userId;
  final String date;

  const LoadCartByDate(this.userId, this.date);

  @override
  List<Object> get props => [userId];
}

class LoadCartRecent extends CartEvent {
  final int userId;

  const LoadCartRecent(this.userId);

  @override
  List<Object> get props => [userId];
}
