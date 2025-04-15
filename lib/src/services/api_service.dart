import 'dart:convert';
import 'package:crypto_pay/src/models/LoginModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://cryptopay.oyefin.com/API/loginPost';

  Future<LoginResponseModel> login(String username, String password) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'username': username,
          'password': password,
        },
      );

      final response = await http
          .post(uri)
          .timeout(const Duration(seconds: 10));

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body) as Map<String, dynamic>;
          return LoginResponseModel.fromJson(json);
        } catch (e) {
          throw Exception('Failed to parse response: $e');
        }
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception('Error during login: $e');
    }
  }
}