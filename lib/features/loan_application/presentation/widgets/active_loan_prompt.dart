import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';
import 'package:loan_app/i18n/i18n.dart';

class ActiveLoanPrompt extends StatelessWidget {
  const ActiveLoanPrompt({
    Key? key,
    required this.loan,
  }) : super(key: key);
  final LoanData loan;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Transform.rotate(
            angle: math.pi / 2,
            child: Text(
              ': (',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'You can only have one loan at a time.'.tr(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Text(
            'Pay off your current loan and then you can apply for a new one.'
                .tr(),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        PayButton.labeled(
          context: context,
          label: 'Pay Now'.tr(),
          onTap: () {
            log('pay on active loan prompt tapped');
            Navigator.of(context).pushNamed(
              LoanPaymentScreen.routeName,
              arguments: LoanPaymentScreenArguments(
                loan: loan,
              ),
            );
          },
        ),
      ],
    );
  }
}
