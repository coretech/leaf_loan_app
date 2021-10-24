import 'package:flutter/material.dart';

class CustomDismissKeyboard extends StatelessWidget {
  final Widget child;

  const CustomDismissKeyboard({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        FocusScope.of(context).unfocus();
      },
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
