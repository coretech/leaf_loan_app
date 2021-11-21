import 'package:flutter/material.dart';

class StatDivider extends StatelessWidget {
  const StatDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 10,
      endIndent: 30,
      indent: 120,
    );
  }
}
