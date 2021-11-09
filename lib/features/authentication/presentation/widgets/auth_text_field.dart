import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.inputFormatters = const [],
    required this.keyboardType,
    this.obscured = false,
    this.onSuffixPressed,
    required this.suffixIcon,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final bool obscured;
  final VoidCallback? onSuffixPressed;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0120F1), width: 0.7),
        ),
        hintText: hintText,
        suffixIcon: GestureDetector(
          child: Icon(suffixIcon),
          onTap: () {
            if (onSuffixPressed != null) {
              onSuffixPressed?.call();
            }
          },
        ),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscured,
    );
  }
}
