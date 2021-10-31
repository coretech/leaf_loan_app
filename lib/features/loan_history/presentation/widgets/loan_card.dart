import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';

class LoanCard extends StatelessWidget {
  const LoanCard({
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
                status: status,
                totalAmount: totalAmount,
              ),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(
              color: _getBorderColor(context),
              width: _getBorderWidth(),
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.25),
                blurRadius: 2.5,
                offset: const Offset(1, 2),
              )
            ],
            color: _getCardColor(context),
          ),
          height: _getCardHeight(),
          padding: const EdgeInsets.all(15),
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
                    _getIcon(),
                    color: _getIconColor(context),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (status == LoanStatus.open)
                Text(
                  "Pay before",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (status == LoanStatus.open)
                Text(
                  "January 15, 2022",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              if (status == LoanStatus.open)
                SizedBox(
                  height: 10,
                ),
              if (status == LoanStatus.open)
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
              if (status == LoanStatus.open)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                  child: PayButton.labeled(
                    context: context,
                    label: 'Pay now',
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
                          text: 'Amount: ',
                        ),
                        TextSpan(
                          style: _getAmountTextStyle(context),
                          text: '${Formatter.formatMoney(totalAmount)} RWF',
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          text: 'Due: ',
                        ),
                        TextSpan(
                          style: _getDueDateTextStyle(context),
                          text: Formatter.formatDate(dueDate),
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
                          style: _getPaidTextStyle(context),
                          text: '${Formatter.formatMoney(paidAmount)} RWF',
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
                          style: _getStatusTextStyle(context),
                          text: _getLoanStatus(),
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
    );
  }

  Color _getBorderColor(BuildContext context) {
    if (status == LoanStatus.open) {
      return Theme.of(context).primaryColor;
    } else {
      return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  Color _getCardColor(BuildContext context) {
    if (status == LoanStatus.open) {
      return Theme.of(context).primaryColorLight;
    } else {
      return Theme.of(context).cardColor;
    }
  }

  Color _getIconColor(BuildContext context) {
    if (status == LoanStatus.open) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Colors.green;
    }
  }

  IconData _getIcon() {
    if (status == LoanStatus.open) {
      return Icons.info;
    } else {
      return Icons.check_circle;
    }
  }

  double _getBorderWidth() {
    if (status == LoanStatus.open) {
      return 3.5;
    } else {
      return 1;
    }
  }

  double _getCardHeight() {
    if (status == LoanStatus.closed) {
      return 110;
    } else {
      return 275;
    }
  }

  String _getLoanStatus() {
    if (status == LoanStatus.closed) {
      return 'Closed';
    } else {
      return 'Open';
    }
  }

  TextStyle? _getAmountTextStyle(BuildContext context) {
    if (status == LoanStatus.closed) {
      return Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Colors.green,
          );
    } else {
      return Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Colors.red,
          );
    }
  }

  TextStyle? _getDueDateTextStyle(BuildContext context) {
    if (status == LoanStatus.closed) {
      return Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: Theme.of(context).hintColor);
    } else {
      return Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.red);
    }
  }

  TextStyle? _getPaidTextStyle(BuildContext context) {
    if (status == LoanStatus.closed) {
      return Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: Theme.of(context).hintColor);
    } else {
      return Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.red);
    }
  }

  TextStyle? _getStatusTextStyle(BuildContext context) {
    if (status == LoanStatus.closed) {
      return Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: Colors.green);
    } else {
      return Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.red);
    }
  }
}
