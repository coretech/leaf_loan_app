import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';

class NoLoansWidget extends StatelessWidget {
  const NoLoansWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Transform.rotate(
          angle: math.pi / 2,
          child: Text(
            ':)',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "You haven't taken a loan on Leaf".tr(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ApplyButton.labeled(
            context: context,
            label: 'Apply for a loan'.tr(),
            onTap: () {
              Navigator.of(context).pushNamed(
                LoanApplicationScreen.routeName,
              );
            },
          ),
        ),
      ],
    );
  }
}
