import 'package:flutter/material.dart';

import 'package:loan_app/features/articles/articles.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanActionButtons extends StatelessWidget {
  const LoanActionButtons({
    Key? key,
    required this.loan,
  }) : super(key: key);
  final LoanData loan;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              LoanPaymentScreen.routeName,
              arguments: LoanPaymentScreenArguments(
                loan: loan,
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.primary,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            fixedSize: MaterialStateProperty.all(const Size(150, 70)),
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          child: Text('Make a Payment'.tr()),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ArticlesScreen.routeName);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            fixedSize: MaterialStateProperty.all(
              const Size(150, 70),
            ),
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          child: Text('Learn More'.tr()),
        ),
      ],
    );
  }
}
