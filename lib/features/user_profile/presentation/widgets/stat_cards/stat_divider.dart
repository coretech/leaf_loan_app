import 'package:flutter/material.dart';

class StatDivider extends StatelessWidget {
  const StatDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.secondary,
      height: 10,
      endIndent: 30,
      indent: 120,
    );
  }
}
