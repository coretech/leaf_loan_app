import 'dart:developer';
import 'dart:math' as math;

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

  final int paymentsCount = math.Random().nextInt(50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                        text: TextSpan(
                          children: [
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
                                  '${Formatter.formatMoney(totalAmount / 1.1)}'
                                  '\n',
                            ),
                            TextSpan(
                              style: Theme.of(context).textTheme.bodyText2,
                              text: 'Amount',
                            ),
                          ],
                        ),
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
                              text: 'RWF ',
                            ),
                            TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              text: '${Formatter.formatMoney(
                                _getInterest(totalAmount),
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
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          if (status != LoanStatus.closed)
                            Text(
                              'Pay before',
                              style: TextStyle(
                                color: _getTextColor(context),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          if (status != LoanStatus.closed)
                            Text(
                              'January 15, 2022',
                              style: TextStyle(
                                color: _getTextColor(context),
                                fontSize: 24,
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
                                  log('big pay button on detail card tapped');
                                  Navigator.of(context)
                                      .pushNamed(LoanPaymentScreen.routeName);
                                },
                              ),
                            ),
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

  Color _getTextColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  double _getInterest(double totalAmount) {
    return totalAmount * 0.1;
  }
}
