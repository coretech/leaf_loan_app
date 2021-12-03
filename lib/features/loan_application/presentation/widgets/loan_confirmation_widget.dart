import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanConfirmationWidget extends StatelessWidget {
  const LoanConfirmationWidget({
    Key? key,
    required this.amount,
    required this.durationDays,
    required this.purpose,
    required this.selectedCurrency,
    required this.loanType,
  }) : super(key: key);
  final double amount;
  final int durationDays;
  final String purpose;
  final Currency selectedCurrency;
  final LoanType loanType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirm Loan Info'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
          Divider(
            height: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Loan Type'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  loanType.name,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Amount'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  '$amount ${selectedCurrency.currencyId.fiatCode}',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Interest Rate'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  '${loanType.interestRate}',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Amount Due'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  '${_getAmountDue()}',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Due Date'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  _getDueDate(context),
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Loan Purpose'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  purpose,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'You will have to pay enter your pin code to confirm this loan'
                .tr(),
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final _ = await showPinConfirmationSheet(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.disabled)
                    ? null
                    : Theme.of(context).colorScheme.secondary,
              ),
              fixedSize: MaterialStateProperty.all(
                Size(
                  ScreenSize.of(context).width - 40,
                  50,
                ),
              ),
            ),
            child: Text(
              'Proceed'.tr(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  double _getAmountDue() {
    return amount + (amount * loanType.interestRate / 100);
  }

  String _getDueDate(BuildContext context) {
    final now = DateTime.now();
    final dueDate = now.add(Duration(days: durationDays));
    return Formatter.formatDate(
      context,
      dueDate,
    );
  }
}
