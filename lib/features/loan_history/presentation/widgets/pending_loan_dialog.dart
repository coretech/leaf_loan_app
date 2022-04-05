import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_history/presentation/widgets/widgets.dart';
import 'package:loan_app/i18n/i18n.dart';

class _PendingLoanDialog extends StatelessWidget {
  const _PendingLoanDialog({
    Key? key,
    required this.hasActiveLoan,
    required this.loanData,
  }) : super(key: key);
  final bool hasActiveLoan;
  final LoanData loanData;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: DialogCloseWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pending ${loanData.loanType}'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Divider(
                height: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
              _buildLabelAndValue(
                context,
                label: 'Requested Amount'.tr(),
                value: '${loanData.currency.fiatCode} '
                    '${Formatter.formatMoney(loanData.requestedAmount)}',
              ),
              _buildLabelAndValue(
                context,
                label: 'Interest Amount'.tr(),
                value: '${loanData.currency.fiatCode} '
                    '${Formatter.formatMoney(loanData.interestAmount)}',
              ),
              _buildLabelAndValue(
                context,
                label: 'Total Amount'.tr(),
                value: '${loanData.currency.fiatCode} '
                    '${Formatter.formatMoney(loanData.totalAmount)}',
              ),
              _buildLabelAndValue(
                context,
                label: 'Loan Duration'.tr(),
                value: '${loanData.duration} ${'days'.tr()}',
              ),
              _buildLabelAndValue(
                context,
                label: 'Due Date'.tr(),
                value: Formatter.formatDate(
                  DateTime.parse(
                    loanData.dueDate,
                  ),
                ),
              ),
              _buildLabelAndValue(
                context,
                label: 'Applied On'.tr(),
                value: Formatter.formatDate(
                  DateTime.parse(loanData.requestDate),
                ),
              ),
              _buildLabelAndValue(
                context,
                label: ''.tr(),
                value: Formatter.formatTime(
                  DateTime.parse(loanData.requestDate),
                ),
              ),
              if (!hasActiveLoan)
                TextButton.icon(
                  icon: const Icon(Icons.close),
                  label: Text('Cancel Application'.tr()),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onPressed: () {},
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelAndValue(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2.5,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showPendingLoanDialog(
  BuildContext context, {
  required bool hasActiveLoan,
  required LoanData loan,
}) {
  return showDialog(
    context: context,
    builder: (context) => _PendingLoanDialog(
      hasActiveLoan: hasActiveLoan,
      loanData: loan,
    ),
  );
}
