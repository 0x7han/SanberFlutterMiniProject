part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}


class LoadProductsBySort extends ProductEvent {
  final String sort;

  const LoadProductsBySort(this.sort);

  @override
  List<Object?> get props => [sort];
}

class LoadProductByCategory extends ProductEvent {
  final String category;

  const LoadProductByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class LoadProductDetail extends ProductEvent {
  final int id;

  const LoadProductDetail(this.id);

  @override
  List<Object> get props => [id];
}
