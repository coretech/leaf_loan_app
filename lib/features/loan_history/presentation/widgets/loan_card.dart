import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 5),
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
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                          ),
                          text: 'RWF ',
                        ),
                        TextSpan(
                          style: _getAmountTextStyle(context),
                          text: Formatter.formatMoney(totalAmount),
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
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 12,
                          ),
                          text: 'RWF ',
                        ),
                        TextSpan(
                          style: _getPaidTextStyle(context),
                          text: Formatter.formatMoney(paidAmount),
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
    return Theme.of(context).scaffoldBackgroundColor;
  }

  Color _getCardColor(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  Color _getIconColor(BuildContext context) {
    return Colors.green;
  }

  IconData _getIcon() {
    return Icons.check_circle;
  }

  double _getBorderWidth() {
    return 1;
  }

  double _getCardHeight() {
    return 110;
  }

  String _getLoanStatus() {
    return 'Closed';
  }

  TextStyle? _getAmountTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Colors.green,
        );
  }

  TextStyle? _getDueDateTextStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Theme.of(context).hintColor);
  }

  TextStyle? _getPaidTextStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Theme.of(context).hintColor);
  }

  TextStyle? _getStatusTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.green);
  }
}
