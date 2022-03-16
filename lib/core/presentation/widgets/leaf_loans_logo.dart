import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';

class LeafLoansLogo extends StatelessWidget {
  const LeafLoansLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            left: 8,
            right: 4,
            top: 8,
          ),
          child: Image.asset(
            'assets/images/leaf_logo_green.png',
            height: 40,
          ),
        ),
        Text(
          'Loans'.tr(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
