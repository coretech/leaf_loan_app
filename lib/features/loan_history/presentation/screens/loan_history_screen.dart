import 'dart:math';

import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';

class LoanHistoryScreen extends StatelessWidget {
  const LoanHistoryScreen({
    Key? key,
    required this.hasLoan,
  }) : super(key: key);

  final bool hasLoan;

  @override
  Widget build(BuildContext context) {
    if (hasLoan) {
      return ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return LoanCard(
              dueDate: DateTime.now().add(const Duration(days: 10)),
              paidAmount: 25000,
              status: LoanStatus.open,
              totalAmount: 50000,
            );
          } else {
            return LoanCard(
              dueDate: DateTime.now().subtract(const Duration(days: 100)),
              paidAmount: 50000,
              status: LoanStatus.closed,
              totalAmount: 50000,
            );
          }
        },
        padding: const EdgeInsets.all(5),
        physics: const BouncingScrollPhysics(),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Transform.rotate(
            angle: pi / 2,
            child: Text(
              ': )',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "You haven't taken a loan on Leaf",
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ApplyButton.labeled(
              context: context,
              label: 'Apply for a loan',
              onTap: () {
                print('apply on no loans tapped');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoanApplicationScreen(
                        hasLoan: true,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
