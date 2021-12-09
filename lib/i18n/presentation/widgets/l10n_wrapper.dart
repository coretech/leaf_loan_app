import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LocalizationWrapper extends StatelessWidget {
  const LocalizationWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LocalizationIOC.l10nProvider(),
      builder: (context, _) {
        return child;
      },
    );
  }
}
