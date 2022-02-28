import 'package:flutter/widgets.dart';

class ScreenSize {
  ScreenSize({
    required this.context,
  });

  factory ScreenSize.of(BuildContext context) {
    return ScreenSize(context: context);
  }

  final BuildContext context;

  double get height => MediaQuery.of(context).size.height;

  double get width => MediaQuery.of(context).size.width;
}
