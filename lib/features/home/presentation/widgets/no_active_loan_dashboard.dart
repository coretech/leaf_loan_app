import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';

class NoActiveLoanDashboard extends StatelessWidget {
  const NoActiveLoanDashboard({
    Key? key,
    required this.onApplyPressed,
  }) : super(key: key);

  final VoidCallback onApplyPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'WELCOME!',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Theme.of(context).canvasColor,
              ),
        ),
        Text(
          'Apply for a loan to get started!',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).canvasColor,
              ),
        ),
        ApplyButton.circular(
          context: context,
          onTap: onApplyPressed,
        ),
      ],
    );
  }
}
