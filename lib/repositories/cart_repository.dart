import 'dart:convert';
import 'package:http/http.dart';
import 'package:sanber_flutter_mini_project_1/model/cart.dart';
import 'package:sanber_flutter_mini_project_1/model/product.dart';
import 'package:sanber_flutter_mini_project_1/repositories/product_repository.dart';

class CartRepository {
  final ProductRepository productRepository = ProductRepository();
  Future<List<Cart>> getCartsByUserId(int userId) async {
    const String url = 'https://fakestoreapi.com/carts';

    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result
          .where((e) => e['userId'] == userId)
          .map((e) => Cart.fromJson(e))
          .toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Product> getProductById(int id) async {
    var url = Uri.parse('https://fakestoreapi.com/products/$id');

    final Response response = await get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return Product.fromJson(body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Product>> getProductsByCart(Cart cart) async {
    final List<Product> allProducts = await productRepository.getProducts();
    List<Product> cartProducts = [];
    for (var cartProduct in cart.products) {
      final product = allProducts
          .firstWhere((product) => product.id == cartProduct.productId);
      cartProducts.add(product);
    }

    return cartProducts;
  }
}
