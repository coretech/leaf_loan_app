import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';

class LoanApplicationScreen extends StatelessWidget {
  const LoanApplicationScreen({
    Key? key,
    required this.hasLoan,
  }) : super(key: key);
  final bool hasLoan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Apply for a loan'.toUpperCase()),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    if (hasLoan) {
      return const ActiveLoanPrompt();
    } else {
      return const LoanApplicationForm();
    }
  }
}
