import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanHistoryScreen extends StatelessWidget {
  const LoanHistoryScreen({
    Key? key,
    this.hasLoan = true,
  }) : super(key: key);

  static const String routeName = '/loan-history-screen';

  final bool hasLoan;

  @override
  Widget build(BuildContext context) {
    if (hasLoan) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          title: Text('Loans History'.tr()),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return ActiveLoanCard(
                dueDate: DateTime.now().add(const Duration(days: 10)),
                paidAmount: 25000,
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
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            Transform.rotate(
              angle: math.pi / 2,
              child: Text(
                ': )',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "You haven't taken a loan on Leaf".tr(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ApplyButton.labeled(
                context: context,
                label: 'Apply for a loan'.tr(),
                onTap: () {
                  log('apply on no loans tapped');
                  Navigator.of(context).pushNamed(
                    LoanApplicationScreen.routeName,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
