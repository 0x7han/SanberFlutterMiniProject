part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Cart> carts;
  final String selectedDate;

  const CartLoaded({required this.carts, required this.selectedDate});

  CartLoaded copyWith({
    List<Cart>? carts,
    String? selectedDate,
  }) => CartLoaded(carts: carts ?? this.carts,
  selectedDate: selectedDate ?? this.selectedDate);

  @override
  List<Object> get props => [carts, selectedDate];
}

class CartError extends CartState {
  final String error;

  const CartError(this.error);

  @override
  List<Object> get props => [error];
}


class CartRecentLoaded extends CartState {
  final int userId;
  final int count;
  final String date;

  const CartRecentLoaded({required this.userId, required this.count, required this.date});

  @override
  List<Object> get props => [userId, count, date];
}
