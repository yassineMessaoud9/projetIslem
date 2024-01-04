import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testtech/Service/Api.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}user/login'),
      body: {
        'email': username,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  }
}
