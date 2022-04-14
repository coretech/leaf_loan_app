import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.inputFormatters = const [],
    this.keyboardType,
    this.obscured = false,
    this.onSuffixPressed,
    this.onSubmit,
    required this.suffixIcon,
    this.textInputAction,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? keyboardType;
  final bool obscured;
  final VoidCallback? onSubmit;
  final VoidCallback? onSuffixPressed;
  final IconData suffixIcon;
  final TextInputAction? textInputAction;

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
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscured,
      onFieldSubmitted: (_) => onSubmit?.call(),
      textInputAction: textInputAction,
    );
  }
}
