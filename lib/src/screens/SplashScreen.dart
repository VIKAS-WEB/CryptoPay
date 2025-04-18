// lib/splash_screen.dart
import 'package:crypto_pay/src/screens/OnBoarding.dart';
import 'package:crypto_pay/src/models/OnboardingPageModel.dart';
import 'package:crypto_pay/src/utils/AnimatedWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  OnboardingPage(
          pages: [
           OnboardingPageModel(
            title: 'Fast, Fluid and Secure',
            description:
                'Enjoy the best of the world in the palm of your hands.',
            image: 'assets/images/image0.png',
            bgColor: Colors.indigo,
          ),
          OnboardingPageModel(
            title: 'Connect with your friends.',
            description: 'Connect with your friends anytime anywhere.',
            image: 'assets/images/image1.png',
            bgColor: const Color(0xff1eb090),
          ),
          OnboardingPageModel(
            title: 'Bookmark your favourites',
            description:
                'Bookmark your favourite quotes to read at a leisure time.',
            image: 'assets/images/image2.png',
            bgColor: const Color(0xfffeae4f),
          ),
          OnboardingPageModel(
            title: 'Follow creators',
            description: 'Follow your favourite creators to stay in the loop.',
            image: 'assets/images/image3.png',
            bgColor: Colors.purple,
          ),
          ],

        )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize as needed
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // You can replace this with your own logo/image
            AnimatedContainerWidget(
                fadeCurve: Easing.legacy,
                child: Image.asset(
                  'assets/images/logo1.png',
                  height: 250,
                )),
            const SizedBox(height: 0),
            AnimatedContainerWidget(
              fadeCurve: Curves.linear,
              child: Text(
                'CryptoPay',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily:
                      'Poppins', // Make sure to add this font in pubspec.yaml
                  letterSpacing: 2,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[
                        Color(0xFFef4923), // Indigo/Deep Purple (match your logo)
                        Color(0xFF333333), // Purple Accent
                      ],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  shadows: const [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
            // const Text(
            //   'Welcome to My App',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 20),
            // const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
