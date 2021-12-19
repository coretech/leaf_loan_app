import 'package:flutter/material.dart';
import 'package:loan_app/core/domain/domain.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanDetailWidget extends StatelessWidget {
  const LoanDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanDetailProvider>(
      builder: (context, loanDetailProvider, _) {
        final loan = loanDetailProvider.loan!;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.spaceEvenly,
                spacing: 20,
                runSpacing: 20,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: _getTextColor(context),
                              ),
                          text: '${loan.currencyId!.fiatCode} ',
                        ),
                        TextSpan(
                          style: Theme.of(context).textTheme.headline6,
                          text: '${Formatter.formatMoney(
                            loan.requestedAmount,
                          )}'
                              '\n',
                        ),
                        TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          text: 'Amount'.tr(),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: _getTextColor(context),
                              ),
                          text: '${loan.currencyId!.fiatCode} ',
                        ),
                        TextSpan(
                          style: Theme.of(context).textTheme.headline6,
                          text: '${Formatter.formatMoney(
                            loan.interestAmount,
                          )}\n',
                        ),
                        TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          text: 'Interest',
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: _getTextColor(context),
                              ),
                          text: '${loan.currencyId!.fiatCode} ',
                        ),
                        TextSpan(
                          style: Theme.of(context).textTheme.headline6,
                          text: '${Formatter.formatMoney(
                            loan.totalAmount,
                          )}'
                              '\n',
                        ),
                        TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          text: 'Total'.tr(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (loanStatusFromString(loan.status) == LoanStatus.approved)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Pay before'.tr(),
                        style: TextStyle(
                          color: _getTextColor(context),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        Formatter.formatDate(
                          DateTime.parse(loan.dueDate),
                        ),
                        style: TextStyle(
                          color: _getTextColor(context),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: PayButton.labeled(
                          context: context,
                          label: 'Pay Now'.tr(),
                          onTap: () {
                            LoanDetailAnalytics.logBigPayButtonTapped();
                            Navigator.of(context).pushNamed(
                              LoanPaymentScreen.routeName,
                              arguments: LoanPaymentScreenArguments(
                                loan: loan,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Color _getTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }
}
