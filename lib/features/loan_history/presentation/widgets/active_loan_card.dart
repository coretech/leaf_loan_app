import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';

class ActiveLoanCard extends StatelessWidget {
  ActiveLoanCard({
    Key? key,
    required this.dueDate,
    required this.paidAmount,
    required this.totalAmount,
  }) : super(key: key);

  final DateTime dueDate;
  final double paidAmount;
  final double totalAmount;
  final LoanStatus status = LoanStatus.open;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoanDetailScreen(
                dueDate: dueDate,
                paidAmount: paidAmount,
                status: LoanStatus.open,
                totalAmount: totalAmount,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '[Category X] Loan',
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
                  "Pay before",
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "January 15, 2022",
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                        color: _getTextColor(context),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                      text: 'Remaining amount\n',
                    ),
                    TextSpan(
                      style: TextStyle(
                        color: _getTextColor(context),
                        fontSize: 12,
                      ),
                      text: 'RWF ',
                    ),
                    TextSpan(
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: _getTextColor(context),
                          ),
                      text:
                          '${Formatter.formatMoney(totalAmount - paidAmount)}',
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                  child: PayButton.labeled(
                    context: context,
                    label: 'Pay now',
                    mini: true,
                    onTap: () {
                      print('pay on loan history card tapped');
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
                            text: 'Total Amount: ',
                          ),
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: 'RWF ',
                          ),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: _getTextColor(context)),
                            text: '${Formatter.formatMoney(totalAmount)} ',
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
                            text: 'Paid: ',
                          ),
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: 'RWF ',
                          ),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: _getTextColor(context)),
                            text: '${Formatter.formatMoney(paidAmount)}',
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
                            text: 'Status: ',
                          ),
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: _getErrorTextColor(context),
                                    ),
                            text: 'Open',
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
    if (status == LoanStatus.overdue) {
      return Theme.of(context).errorColor;
    }
    return Theme.of(context).colorScheme.secondary;
  }

  Color _getGradientColor(BuildContext context) {
    if (status == LoanStatus.overdue || status == LoanStatus.due) {
      return Theme.of(context).errorColor;
    }
    return Theme.of(context).colorScheme.secondary;
  }

  Color _getTextColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  Color _getErrorTextColor(BuildContext context) {
    if (status == LoanStatus.overdue) {
      return Theme.of(context).colorScheme.onSurface;
    }
    return Theme.of(context).errorColor;
  }
}
