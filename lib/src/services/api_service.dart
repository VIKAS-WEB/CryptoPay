import 'dart:convert';
import 'package:crypto_pay/src/models/LoginModel.dart';
import 'package:crypto_pay/src/utils/AuthManager.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://cryptopay.oyefin.com/API/loginPost';
  static const String loggedHistoryUrl = 'https://cryptopay.oyefin.com/API/LoggedHistory';
  static const String customerListUrl = 'https://cryptopay.oyefin.com/API/AppCustomer';

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

  static Future<http.Response> fetchLoginHistory() async {
    final userData = await AuthManager.getUserData();
    final merchantId = userData?['merchantId']?.toString() ?? '190'; // Default to 190 if null
    
    final headers = {
      'MerchantID': merchantId.toString(),
    };

    return await http.get(Uri.parse(loggedHistoryUrl), headers: headers);
  }

  Future<http.Response> fetchCustomerList({
    int limit = 100, // Default to 100, max 500
    String? dateFrom,
    String? dateTo,
  }) async {
    if (limit > 500) limit = 500; // Enforce max limit of 500

    final userData = await AuthManager.getUserData();
    final merchantId = userData?['merchantId']?.toString() ?? '190'; // Default to 190 if null

    final queryParams = {
      'limit': limit.toString(),
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
    };

    final uri = Uri.parse(customerListUrl).replace(queryParameters: queryParams);
    final headers = {
      'MerchantID': merchantId.toString(),
    };

    return await http.get(uri, headers: headers);
  }
}