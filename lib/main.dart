import 'dart:ffi';

import 'package:crypto_pay/src/providers/Auth_Provider.dart';
import 'package:crypto_pay/src/screens/HomeScreen.dart';
import 'package:crypto_pay/src/screens/OnBoarding.dart';
import 'package:crypto_pay/src/screens/payrequest/PayRequestScreen.dart';
import 'package:crypto_pay/src/screens/SplashScreen.dart';
import 'package:crypto_pay/src/models/OnboardingPageModel.dart';
import 'package:crypto_pay/src/screens/LoginScreen.dart';
import 'package:crypto_pay/src/screens/payrequest/payrequest.dart';
import 'package:crypto_pay/src/screens/paylinks/plink.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: SplashScreen(),
      
      ),
    );
  }
}