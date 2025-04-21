import 'package:crypto_pay/src/providers/Auth_Provider.dart';
import 'package:crypto_pay/src/screens/CustomerList/CustomerList.dart';
import 'package:crypto_pay/src/screens/ForgotPassword/ForgotPassword.dart';
import 'package:crypto_pay/src/screens/ForgotPassword/OtpScreen.dart';
import 'package:crypto_pay/src/screens/HomeScreen.dart';
import 'package:crypto_pay/src/screens/LoginScreen.dart';
import 'package:crypto_pay/src/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
       // ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home:  const OtpScreen())
    );
  }
}   