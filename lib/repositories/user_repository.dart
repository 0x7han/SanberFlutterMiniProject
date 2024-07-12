import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sanber_flutter_mini_project_1/model/user.dart';

class UserRepository {
  final String _baseUrl = 'https://fakestoreapi.com';
  final Map<String, String> _headers = {
    "Content-Type": "application/json",
  };

  Future<User> getById(int id) async {
    var url = Uri.parse('$_baseUrl/users/$id');

    final http.Response response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return User.fromJson(body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

}
