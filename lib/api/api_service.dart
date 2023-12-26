import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "https://fakestoreapi.com";
  ApiService() : super();

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + endpoint));
      return json.decode(response.body);
    } catch (e) {
      return e;
    }
  }
}
