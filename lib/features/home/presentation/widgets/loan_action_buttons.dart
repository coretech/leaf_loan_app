import 'package:flutter/material.dart';
import 'package:loan_app/features/articles/articles.dart';

class LoanActionButtons extends StatelessWidget {
  const LoanActionButtons({
    Key? key,
    required this.hasActiveLoan,
    this.onApply,
    this.onPay,
  }) : super(key: key);
  final bool hasActiveLoan;
  final VoidCallback? onApply;
  final VoidCallback? onPay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (hasActiveLoan)
          TextButton(
            onPressed: () {},
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
        if (hasActiveLoan)
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
