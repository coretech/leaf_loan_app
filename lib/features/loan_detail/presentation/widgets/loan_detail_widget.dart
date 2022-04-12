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
              Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  trailing: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const SizedBox(
                        width: 40,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: _getTextColor(context),
                                      ),
                              text: '${loan.currency.fiatCode} ',
                            ),
                            TextSpan(
                              style: TextStyle(
                                color: _getTextColor(context),
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
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
                      const Spacer(),
                    ],
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                                text: '${loan.currency.fiatCode} ',
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
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                                text: '${loan.currency.fiatCode} ',
                              ),
                              TextSpan(
                                style: Theme.of(context).textTheme.headline6,
                                text: '${Formatter.formatMoney(
                                  loan.interestAmount,
                                )}\n',
                              ),
                              TextSpan(
                                style: Theme.of(context).textTheme.bodyText2,
                                text: 'Interest'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loan.loanPurpose,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            'Loan Purpose'.tr(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (loanStatusFromString(loan.status) == LoanStatus.approved)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Pay before'.tr(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        Formatter.formatDate(
                          DateTime.parse(loan.dueDate),
                        ),
                        style: Theme.of(context).textTheme.headline6,
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
                ),
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
