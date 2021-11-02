import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final int? maxlines;
  final validator, onsaved;

  const AuthTextField(
      {required this.hintText, this.validator, this.onsaved, this.maxlines});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onsaved,
      keyboardType: hintText == 'Username'
          ? TextInputType.emailAddress
          : TextInputType.text,
      obscureText: hintText == 'Password',
      maxLines: maxlines ?? 1,
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
              horizontal: 10, vertical: maxlines != null ? 10 : 0)),
    );
  }
}
