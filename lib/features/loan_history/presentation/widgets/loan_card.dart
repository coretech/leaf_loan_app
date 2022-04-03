import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanCard extends StatelessWidget {
  const LoanCard({
    Key? key,
    required this.loan,
    required this.hasActiveLoan,
  }) : super(key: key);

  final LoanData loan;
  final bool hasActiveLoan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _showLoanDetail(context),
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
                    loan.loanType,
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
                          text: '${'Amount'.tr()}: ',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                          ),
                          text: '${loan.currency.fiatCode} ',
                        ),
                        TextSpan(
                          style: _getAmountTextStyle(context),
                          text: Formatter.formatMoney(loan.totalAmount),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          text: '${'Due'.tr()}: ',
                        ),
                        TextSpan(
                          style: _getDueDateTextStyle(context),
                          text: Formatter.formatDateMini(
                            DateTime.parse(loan.dueDate),
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
                          text: '${'Paid'.tr()}: ',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 12,
                          ),
                          text: '${loan.currency.fiatCode} ',
                        ),
                        TextSpan(
                          style: _getPaidTextStyle(context),
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
                          style: Theme.of(context).textTheme.bodyText1,
                          text: '${'Status'.tr()}: ',
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
                          text: '${'Applied On'.tr()}: ',
                        ),
                        TextSpan(
                          style: _getPaidTextStyle(context),
                          text: '${Formatter.formatDate(
                            DateTime.parse(loan.requestDate),
                          )} ',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'View Details'.tr(),
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
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
    final status = loanStatusFromString(loan.status);
    switch (status) {
      case LoanStatus.approved:
        return Theme.of(context).colorScheme.primary;
      case LoanStatus.pending:
        return Theme.of(context).disabledColor;
      case LoanStatus.rejected:
        return Theme.of(context).errorColor;
      case LoanStatus.due:
        return Theme.of(context).colorScheme.secondary;
      case LoanStatus.cancelled:
        return Theme.of(context).colorScheme.error;
      case LoanStatus.closed:
        return Theme.of(context).disabledColor;
    }
  }

  IconData _getIcon() {
    final status = loanStatusFromString(loan.status);
    switch (status) {
      case LoanStatus.approved:
        return Icons.check_circle;
      case LoanStatus.pending:
        return Icons.hourglass_empty;
      case LoanStatus.rejected:
        return Icons.cancel;
      case LoanStatus.cancelled:
        return Icons.cancel;
      case LoanStatus.due:
        return Icons.warning;
      case LoanStatus.closed:
        return Icons.check_circle;
    }
  }

  double _getBorderWidth() {
    return 1;
  }

  double _getCardHeight() {
    return 145;
  }

  String _getLoanStatus() {
    final status = loanStatusFromString(loan.status);
    switch (status) {
      case LoanStatus.approved:
        return 'Approved'.tr();
      case LoanStatus.rejected:
        return 'Rejected'.tr();
      case LoanStatus.pending:
        return 'Pending'.tr();
      case LoanStatus.cancelled:
        return 'Cancelled'.tr();
      case LoanStatus.due:
        return 'Due'.tr();
      case LoanStatus.closed:
        return 'Closed'.tr();
    }
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
    if (loanStatusFromString(loan.status) == LoanStatus.pending) {
      return Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          );
    } else if (loanStatusFromString(loan.status) == LoanStatus.rejected ||
        loanStatusFromString(loan.status) == LoanStatus.cancelled) {
      return Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Theme.of(context).colorScheme.error,
          );
    }
    return Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.green);
  }

  void _showLoanDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      LoanDetailScreenAlt.routeName,
      arguments: LoanDetailScreenAltArgs(
        hasActiveLoan: true,
        loan: loan,
      ),
    );
    // if (loanStatusFromString(loan.status) == LoanStatus.pending) {
    //   showPendingLoanDialog(
    //     context,
    //     loan: loan,
    //     hasActiveLoan: hasActiveLoan,
    //   );
    // } else if (loanStatusFromString(loan.status) == LoanStatus.rejected) {
    //   showRejectedLoanDialog(
    //     context,
    //     loan: loan,
    //     hasActiveLoan: hasActiveLoan,
    //   );
    // } else {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => LoanDetailScreen(
    //         loan: loan,
    //       ),
    //     ),
    //   );
    // }
  }
}
