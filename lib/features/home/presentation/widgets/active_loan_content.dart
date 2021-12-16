import 'package:flutter/material.dart';

import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/home/presentation/providers/home_provider.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class ActiveLoanContent extends StatefulWidget {
  const ActiveLoanContent({
    Key? key,
    required this.loadingPayments,
    required this.loan,
    required this.payments,
  }) : super(key: key);
  final bool loadingPayments;
  final LoanData loan;
  final List<Payment> payments;

  @override
  State<ActiveLoanContent> createState() => _ActiveLoanContentState();
}

class _ActiveLoanContentState extends State<ActiveLoanContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return RefreshIndicator(
          onRefresh: () async {
            await Provider.of<HomeProvider>(context, listen: false)
                .getActiveLoan();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: SizedBox(
                height: constraint.maxHeight,
                child: Column(
                  children: [
                    CurrentLoanInfo(
                      loan: widget.loan,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: LoanActionButtons(
                        loan: widget.loan,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Recent Transactions'.tr(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    if (widget.loadingPayments)
                      Expanded(
                        child: RecentTransactions.shimmer(context),
                      )
                    else
                      Expanded(
                        child: RecentTransactions(
                          currencyFiat: widget.loan.currencyId!.fiatCode,
                          loan: widget.loan,
                          payments: widget.payments.reversed.toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
