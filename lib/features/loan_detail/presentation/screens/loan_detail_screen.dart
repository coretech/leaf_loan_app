import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';

class LoanDetailScreen extends StatelessWidget {
  LoanDetailScreen({
    Key? key,
    required this.dueDate,
    required this.paidAmount,
    required this.status,
    required this.totalAmount,
  }) : super(key: key);

  final DateTime dueDate;
  final double paidAmount;
  final LoanStatus status;
  final double totalAmount;

  final int paymentsCount = Random().nextInt(50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LoanDetailAppBar(
            dueDate: dueDate,
            paidAmount: paidAmount,
            status: status,
            totalAmount: totalAmount,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.spaceEvenly,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: 'RWF ',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.headline6,
                            text:
                                '${Formatter.formatMoney(totalAmount / 1.1)}\n',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            text: 'Amount',
                          ),
                        ]),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: 'RWF ',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.headline6,
                            text:
                                '${Formatter.formatMoney(totalAmount - (totalAmount / 1.1))}\n',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            text: 'Interest',
                          ),
                        ]),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: _getTextColor(context),
                                    ),
                            text: 'RWF ',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.headline6,
                            text: '${Formatter.formatMoney(totalAmount)}\n',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            text: 'Total',
                          ),
                        ]),
                      ),
                      Column(
                        children: [
                          if (status != LoanStatus.closed)
                            Text(
                              "Pay before",
                              style: TextStyle(
                                color: _getTextColor(context),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          if (status != LoanStatus.closed)
                            Text(
                              "January 15, 2022",
                              style: TextStyle(
                                color: _getTextColor(context),
                                fontSize: 24.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          if (status != LoanStatus.closed)
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, top: 15),
                              child: PayButton.labeled(
                                context: context,
                                label: 'Pay now',
                                onTap: () {
                                  print('big pay button on detail card tapped');
                                },
                              ),
                            ),
                          // Padding(
                          //   padding: const EdgeInsets.all(5.0),
                          //   child: Center(
                          //     child: RichText(
                          //       text: TextSpan(
                          //         children: [
                          //           TextSpan(
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .subtitle1,
                          //             text: 'Status: ',
                          //           ),
                          //           TextSpan(
                          //             style: _getValueTextStyle(context),
                          //             text: _getLoanStatus(),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            delegate: PaymentsHistoryColumnLabels(),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.5, horizontal: 15),
                  child: PaymentDetailCard(
                    disbursement: index == paymentsCount - 1,
                  ),
                );
              },
              childCount: paymentsCount,
            ),
          )
        ],
      ),
    );
  }

  // String _getLoanStatus() {
  //   if (status == LoanStatus.closed) {
  //     return 'Closed'.toUpperCase();
  //   } else {
  //     return 'Open'.toUpperCase();
  //   }
  // }

  Color _getTextColor(BuildContext context) {
    if (status != LoanStatus.closed) {
      return Theme.of(context).colorScheme.onSurface;
    }
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }
}
