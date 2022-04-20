import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/home/presentation/analytics/analytics.dart';
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
      return const CustomErrorWidget(
        message: "Looks like you haven't made any payments yet.",
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: _buildTransactions(context),
          ),
        ),
        FittedBox(
          child: TextButton(
            onPressed: () {
              HomeAnalytics.homeShowMoreTapped();
              Navigator.of(context).pushNamed(
                LoanDetailScreenAlt.routeName,
                arguments: LoanDetailScreenAltArgs(
                  hasActiveLoan: true,
                  loan: loan,
                ),
              );
            },
            child: Text('show more'.tr()),
          ),
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

  static Widget shimmer(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      shrinkWrap: true,
      children: [
        const SizedBox(height: 14),
        TransactionCard.shimmer(context),
        const SizedBox(height: 14),
        TransactionCard.shimmer(context),
        const SizedBox(height: 14),
        TransactionCard.shimmer(context),
        const SizedBox(height: 20),
        const ShimmerBox(width: 150, height: 20)
      ],
    );
  }
}
