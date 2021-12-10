import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';
import 'package:loan_app/i18n/i18n.dart';

class ActiveLoanCard extends StatelessWidget {
  const ActiveLoanCard({
    Key? key,
    required this.loan,
  }) : super(key: key);
  final LoanData loan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoanDetailScreen(
                loan: loan,
              ),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.25),
                blurRadius: 2.5,
                offset: const Offset(1, 2),
              )
            ],
            color: _getColor(context),
          ),
          height: 275,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Colors.white.withOpacity(0.25),
                  _getGradientColor(context).withRed(205),
                  _getGradientColor(context).withRed(205).withGreen(150),
                  _getGradientColor(context),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loan.loanTypeId.name,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: _getTextColor(context),
                            fontSize: 18,
                          ),
                    ),
                    Icon(
                      Icons.info,
                      color: _getTextColor(context),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Pay before'.tr(),
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'January 15, 2022',
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: _getTextColor(context),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        text: '${'Remaining amount'.tr()}\n',
                      ),
                      TextSpan(
                        style: TextStyle(
                          color: _getTextColor(context),
                          fontSize: 12,
                        ),
                        text: '${loan.currencyId.fiatCode} ',
                      ),
                      TextSpan(
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: _getTextColor(context),
                            ),
                        text: Formatter.formatMoney(loan.remainingAmount),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: PayButton.labeled(
                    context: context,
                    label: 'Pay Now'.tr(),
                    mini: true,
                    onTap: () {
                      log('pay on loan history card tapped');
                      Navigator.of(context).pushNamed(
                        LoanPaymentScreen.routeName,
                        arguments: LoanPaymentScreenArguments(
                          loan: loan,
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: _getTextColor(context)),
                            text: '${'Total Amount'.tr()}: ',
                          ),
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: '${loan.currencyId.fiatCode} ',
                          ),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: _getTextColor(context)),
                            text: '${Formatter.formatMoney(loan.totalAmount)} ',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: _getTextColor(context)),
                            text: '${'Paid'.tr()}: ',
                          ),
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: '${loan.currencyId.fiatCode} ',
                          ),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: _getTextColor(context)),
                            text: Formatter.formatMoney(
                              loan.totalAmount - loan.remainingAmount,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: _getTextColor(context)),
                            text: '${'Status'.tr()}: ',
                          ),
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: 'Open'.tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    if (loanStatusFromString(loan.status) == LoanStatus.rejected) {
      return Theme.of(context).errorColor;
    }
    return Theme.of(context).colorScheme.secondary;
  }

  Color _getGradientColor(BuildContext context) {
    if (loanStatusFromString(loan.status) == LoanStatus.rejected ||
        loanStatusFromString(loan.status) == LoanStatus.due) {
      return Theme.of(context).errorColor;
    }
    return Theme.of(context).colorScheme.secondary;
  }

  Color _getTextColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }
}
