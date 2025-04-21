import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {
  const   InputCustomizado({
    super.key,
    required this.hint,
    this.obscure = false,
    this.icon = const Icon(Icons.person),
    this.controller,
    this.validator,
  });

  final String hint;
  final bool obscure;
  final Icon icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}