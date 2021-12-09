import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';
import 'package:loan_app/i18n/i18n.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({
    Key? key,
    required this.payments,
    required this.currencyFiat,
  }) : super(key: key);
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
                  dueDate: DateTime.now(),
                  paidAmount: 234325,
                  status: LoanStatus.due,
                  totalAmount: 10234324,
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
    for (var i = 0; i < payments.length % 3; i++) {
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
