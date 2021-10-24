import 'package:flutter/cupertino.dart';

class ScreenSize {
  final BuildContext context;
  ScreenSize({
    required this.context,
  });

  factory ScreenSize.of(BuildContext context) {
    return ScreenSize(context: context);
  }

  get height => MediaQuery.of(context).size.height;

  get width => MediaQuery.of(context).size.width;
}
