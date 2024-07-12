class Cart {
  final int id;
  final int userId;
  final String date;
  final List<Map<String, dynamic>> products;

  const Cart(
      {required this.id,
      required this.userId,
      required this.date,
      required this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'userId': int userId,
        'date': String date,
        'products': List<dynamic> products,
      } =>
        Cart(id: id, userId: userId, date: date, products: products.map((e) => e as Map<String, dynamic>).toList()),
      _ => throw FormatException('Failed to load Cart'),
    };
  }
}