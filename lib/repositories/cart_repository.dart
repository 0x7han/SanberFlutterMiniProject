import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sanber_flutter_mini_project_1/model/cart.dart';

class CartRepository {
  final String _baseUrl = 'https://fakestoreapi.com';
  final Map<String, String> _headers = {
    "Content-Type": "application/json",
  };

  Future<List<Cart>> getByUserId(int userId) async {
    var url = Uri.parse('$_baseUrl/carts');

    final http.Response response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);

      return body
          .where((e) => e['userId'] == userId)
          .map((e) => Cart.fromJson(e))
          .toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
