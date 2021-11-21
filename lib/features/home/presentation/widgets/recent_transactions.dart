import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        const TransactionCard(),
        const TransactionCard(),
        const TransactionCard(),
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
          child: const Text('show more'),
        )
      ],
    );
  }
}
