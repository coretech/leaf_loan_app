import 'package:flutter/material.dart';

class CustomDismissKeyboard extends StatelessWidget {
  const CustomDismissKeyboard({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  final Widget child;

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
