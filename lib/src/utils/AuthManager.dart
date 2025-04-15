// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class AuthManager {
//   static const String _userDataKey = 'user_data';

//   // Save user data to SharedPreferences
//   static Future<void> saveUserData({
//     required String merchantName,
//     required String merchantEmail,
//     required int merchantId,
//     required String merchantLoginIp,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final userData = {
//       'merchantName': merchantName,
//       'merchantEmail': merchantEmail,
//       'merchantId': merchantId,
//       'merchantLoginIp': merchantLoginIp,
//     };
//     await prefs.setString(_userDataKey, jsonEncode(userData));
//   }

//   // Retrieve user data from SharedPreferences
//   static Future<Map<String, dynamic>?> getUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userDataString = prefs.getString(_userDataKey);
//     if (userDataString != null) {
//       return jsonDecode(userDataString) as Map<String, dynamic>;
//     }
//     return null;
//   }

//   // Get specific field from user data
//   static Future<String?> getMerchantName() async {
//     final userData = await getUserData();
//     return userData?['merchantName'] as String?;
//   }

//   // Check if user is authenticated
//   static Future<bool> isAuthenticated() async {
//     final userData = await getUserData();
//     return userData != null;
//   }

//   // Clear user data
//   static Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_userDataKey);
//   }
// }