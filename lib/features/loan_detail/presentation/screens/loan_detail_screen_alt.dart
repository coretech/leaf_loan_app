import 'package:flutter/material.dart';

import 'package:loan_app/features/loan_history/domain/entities/entities.dart';

class LoanDetailScreenAlt extends StatelessWidget {
  const LoanDetailScreenAlt({
    Key? key,
    required this.loan,
  }) : super(key: key);
  static const String routeName = '/loan-detail-screen-alt';
  final LoanData loan;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
