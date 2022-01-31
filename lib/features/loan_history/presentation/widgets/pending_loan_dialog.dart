import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/i18n/i18n.dart';

class _PendingLoanDialog extends StatelessWidget {
  const _PendingLoanDialog({
    Key? key,
    required this.loanData,
  }) : super(key: key);
  final LoanData loanData;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLabelAndValue(
              context,
              label: 'Loan Amount'.tr(),
              value: Formatter.formatMoney(loanData.totalAmount),
            ),
            _buildLabelAndValue(
              context,
              label: 'Loan Duration'.tr(),
              value: '${loanData.duration} days',
            ),
            _buildLabelAndValue(
              context,
              label: 'Interest Amount'.tr(),
              value: '${loanData.interestAmount}',
            ),
            _buildLabelAndValue(
              context,
              label: 'Applied Date'.tr(),
              value: Formatter.formatDateWithTime(
                DateTime.parse(loanData.createdAt),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelAndValue(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
          ),
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
    );
  }
}

Future<void> showPendingLoanDialog(BuildContext context, LoanData loanData) {
  return showDialog(
    context: context,
    builder: (context) => _PendingLoanDialog(
      loanData: loanData,
    ),
  );
}
