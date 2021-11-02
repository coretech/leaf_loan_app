import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const AuthTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: hintText == 'Username'
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: hintText == 'Password',
      decoration: InputDecoration(
          suffixIcon: hintText == "Username"
              ? Icon(Icons.check)
              : Icon(Icons.remove_red_eye),
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 0.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0120F1), width: 0.7)),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          )),
    );
  }
}
