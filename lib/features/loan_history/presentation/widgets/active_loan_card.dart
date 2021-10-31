import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';

class ActiveLoanCard extends StatelessWidget {
  const ActiveLoanCard({
    Key? key,
    required this.dueDate,
    required this.paidAmount,
    required this.totalAmount,
  }) : super(key: key);

  final DateTime dueDate;
  final double paidAmount;
  final double totalAmount;

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
            // border: Border.all(
            //   color: Theme.of(context).primaryColor,
            //   width: 3.5,
            // ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.25),
                blurRadius: 2.5,
                offset: const Offset(1, 2),
              )
            ],
            color: Theme.of(context).colorScheme.secondary,
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
                  Colors.black.withOpacity(0.25),
                  Theme.of(context).colorScheme.secondary,
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
                            fontSize: 18,
                          ),
                    ),
                    Icon(
                      Icons.info,
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Pay before",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "January 15, 2022",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      style: Theme.of(context).textTheme.caption,
                      text: 'Remaining amount\n',
                    ),
                    TextSpan(
                      style: Theme.of(context).textTheme.headline6,
                      text:
                          '${Formatter.formatMoney(totalAmount - paidAmount)}',
                    ),
                    TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 12,
                      ),
                      text: ' RWF',
                    )
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
                            style: Theme.of(context).textTheme.bodyText1,
                            text: 'Total Amount: ',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            text: '${Formatter.formatMoney(totalAmount)} ',
                          ),
                          TextSpan(
                            text: 'RWF',
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
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
                            style: Theme.of(context).textTheme.bodyText1,
                            text: 'Paid: ',
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            text: '${Formatter.formatMoney(paidAmount)} ',
                          ),
                          TextSpan(
                            text: 'RWF',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            text: 'Status: ',
                          ),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.red),
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
}
