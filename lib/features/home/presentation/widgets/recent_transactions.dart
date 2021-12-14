import 'package:flutter/material.dart';

import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';
import 'package:loan_app/i18n/i18n.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({
    Key? key,
    required this.loan,
    required this.payments,
    required this.currencyFiat,
  }) : super(key: key);
  final LoanData loan;
  final List<Payment> payments;
  final String currencyFiat;

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('No transactions were found'),
          ],
        ),
      );
    }
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: _buildTransactions(context),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoanDetailScreen(
                  loan: loan,
                ),
              ),
            );
          },
          child: Text('show more'.tr()),
        ),
      ],
    );
  }

  List<Widget> _buildTransactions(BuildContext context) {
    final transactions = <Widget>[];
    final paymentsCount = payments.length > 3 ? 3 : payments.length;
    for (var i = 0; i < paymentsCount; i++) {
      final payment = payments[i];
      transactions.add(
        TransactionCard(
          payment: payment,
          currencyFiat: currencyFiat,
        ),
      );
    }
    return transactions;
  }
}
