import 'package:flutter/material.dart';
import 'package:loan_app/features/articles/articles.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';

class LoanActionButtons extends StatelessWidget {
  const LoanActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(LoanPaymentScreen.routeName);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.primary,
            ),
            elevation: MaterialStateProperty.all(5),
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
          child: const Text('Pay your loan'),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ArticlesScreen.routeName);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
              Theme.of(context).colorScheme.onSurface,
            ),
          ),
          child: const Text('More info'),
        ),
      ],
    );
  }
}
