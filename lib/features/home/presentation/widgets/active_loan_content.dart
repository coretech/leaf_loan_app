import 'package:flutter/material.dart';

import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';
import 'package:loan_app/i18n/i18n.dart';

class ActiveLoanContent extends StatefulWidget {
  const ActiveLoanContent({
    Key? key,
    required this.loan,
    required this.payments,
  }) : super(key: key);
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
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: SizedBox(
              height: constraint.maxHeight,
              child: Column(
                children: [
                  CurrentLoanInfo(
                    loan: widget.loan,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LoanActionButtons(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Recent Transactions'.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Expanded(
                    child: RecentTransactions(
                      currencyFiat: widget.loan.currencyId.fiatCode,
                      payments: widget.payments,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
