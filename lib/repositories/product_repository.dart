import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sanber_flutter_mini_project_1/model/product.dart';

class ProductRepository {
  final String _baseUrl = 'https://fakestoreapi.com';
  final Map<String, String> _headers = {
    "Content-Type": "application/json",
  };

  Future<List<Product>> getProducts() async {
    var url = Uri.parse('$_baseUrl/products');

    final http.Response response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Product> getById(int id) async {
    var url = Uri.parse('$_baseUrl/products/$id');

    final http.Response response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return Product.fromJson(body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

}
