import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/presentation/analytics/analytics.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/i18n/i18n.dart';

class ActiveLoanInfo extends StatelessWidget {
  const ActiveLoanInfo({
    Key? key,
    required this.loan,
  }) : super(key: key);
  final LoanData loan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        HomeAnalytics.homeLoanCardTapped();
        Navigator.of(context).pushNamed(
          LoanDetailScreenAlt.routeName,
          arguments: LoanDetailScreenAltArgs(
            hasActiveLoan: true,
            loan: loan,
          ),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Stack(
          children: [
            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.black.withOpacity(0.25),
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  Text(
                    'Pay before'.tr(),
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    _getDate(context),
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Remaining Amount'.tr(),
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${loan.currency.fiatCode} ',
                          style: TextStyle(
                            color: _getTextColor(context),
                          ),
                        ),
                        TextSpan(
                          text: Formatter.formatMoney(loan.remainingAmount),
                          style: TextStyle(
                            color: _getTextColor(context),
                            fontSize: 31,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.info,
                  color: _getTextColor(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  String _getDate(BuildContext context) {
    return Formatter.formatDate(DateTime.parse(loan.dueDate));
  }
}
