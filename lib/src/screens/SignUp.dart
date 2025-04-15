import 'dart:ui';
import 'package:crypto_pay/src/screens/InputCustomizado%20.dart';

import 'package:crypto_pay/src/screens/LoginScreen.dart';
import 'package:crypto_pay/src/screens/button.dart';
import 'package:crypto_pay/src/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animacaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;
  bool _isChecked = false; // State for the agreement checkbox

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animacaoBlur = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease,
      ),
    );

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.decelerate,
      ),
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120,),
                ClipPath(
              clipper: ArcClipper(),
              child: AnimatedBuilder(
                animation: _animacaoBlur!,
                builder: (context, widget) {
                  return Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo1.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animacaoBlur!.value,
                        sigmaY: _animacaoBlur!.value,
                      ),
                      child: Container(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Column(
                children: [
                  Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please Fill in the form below',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _animacaoSize!,
                    builder: (context, widget) {
                      return Container(
                        width: _animacaoSize?.value,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                    color: Color.fromRGBO(240, 152, 70, 1),
                              blurRadius: 80,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            const InputCustomizado(
                              hint: 'Your Full Name',
                              obscure: false,
                              icon: Icon(Icons.email),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                            ),
                            const InputCustomizado(
                              hint: 'Enter Email Address',
                              obscure: true,
                              icon: Icon(Icons.lock),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                          const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked, // Bind to state
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false; // Update state
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'By creating an account you agree to the ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              fontSize: 12
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(color: AppColors.kprimary, fontSize: 12),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to Terms & Conditions page
                                    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => TermsPage()));
                                  },
                              ),
                              TextSpan(
                                text: ' and our ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(color: AppColors.kprimary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to Privacy Policy page
                                    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPage()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Checkbox(
                  //           value: _isChecked, // Bind to state
                  //           onChanged: (bool? value) {
                  //             setState(() {
                  //               _isChecked = value ?? false; // Update state
                  //             });
                  //           },
                  //         ),
                  //         Text(
                  //           "Remember me",
                  //           style: TextStyle(
                  //             color: Colors.black54,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     TextButton(
                  //       onPressed: () {
                  //         // Handle forget password logic here
                  //       },
                  //       child: Text(
                  //         "Forget Password?",
                  //         style: TextStyle(
                  //           color: Colors.black54,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  Button(controller: _controller!, onTap: (){}, backgroundColor: AppColors.kprimary, text: 'Sign Up',), // Login button remains unchanged
                  
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account? ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: AppColors.kprimary,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for the arc shape
class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50); // Start from the bottom
    path.quadraticBezierTo(
      size.width / 2,
      size.height, // Control point for the arc peak
      size.width,
      size.height - 50, // End point
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}