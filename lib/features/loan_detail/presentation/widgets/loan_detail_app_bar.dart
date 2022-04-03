import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/presentation/analytics/analytics.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanDetailAppBar extends StatelessWidget {
  const LoanDetailAppBar({
    Key? key,
    required this.loan,
  }) : super(key: key);
  final LoanData loan;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      bottom: _getRemainingAmount(context),
      backgroundColor: _getBackgroundColor(context),
      centerTitle: true,
      foregroundColor: loanStatusFromString(loan.status) != LoanStatus.approved
          ? Theme.of(context).colorScheme.onSurface
          : Theme.of(context).colorScheme.onPrimary,
      floating: true,
      forceElevated: true,
      pinned: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(loan.loanType),
          if (loanStatusFromString(loan.status) == LoanStatus.approved)
            const Spacer(),
          if (loanStatusFromString(loan.status) == LoanStatus.approved)
            Text(
              '${_getRemainingDays()} ${'days remaining'.tr()}',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).canvasColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
        ],
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (loanStatusFromString(loan.status) == LoanStatus.approved) {
      return Theme.of(context).colorScheme.secondary.withRed(210).withBlue(55);
    }
    return null;
  }

  AppBar? _getRemainingAmount(context) {
    if (loanStatusFromString(loan.status) == LoanStatus.approved) {
      return AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: PayButton.labeled(
                context: context,
                label: 'Pay'.tr(),
                mini: true,
                onTap: () {
                  LoanDetailAnalytics.logSmallPayButtonTapped();
                  Navigator.of(context).pushNamed(
                    LoanPaymentScreen.routeName,
                    arguments: LoanPaymentScreenArguments(
                      loan: loan,
                    ),
                  );
                },
              ),
            ),
          )
        ],
        backgroundColor: _getBackgroundColor(context),
        centerTitle: true,
        foregroundColor:
            loanStatusFromString(loan.status) != LoanStatus.approved
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                text: '${'Remaining amount'.tr()}\n',
              ),
              TextSpan(
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                text: 'RWF ',
              ),
              TextSpan(
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                text: Formatter.formatMoney(loan.remainingAmount),
              )
            ],
          ),
        ),
      );
    } else {
      return AppBar(
        backgroundColor: _getBackgroundColor(context),
        centerTitle: true,
        elevation: 0,
        title: Text('Completely Paid'.tr()),
      );
    }
  }

  int _getRemainingDays() {
    return DateTime.parse(loan.dueDate).difference(DateTime.now()).inDays;
  }
}
