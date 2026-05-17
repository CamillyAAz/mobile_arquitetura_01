import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_user.dart';

class AuthService {
  static const String _baseUrl = 'https://dummyjson.com/auth';

  Future<AuthUser> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      return AuthUser.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    throw Exception('Usuario ou senha invalidos');
  }

  Future<Map<String, dynamic>> getCurrentUser(String accessToken) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Token invalido ou expirado');
  }
}
