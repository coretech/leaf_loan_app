import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/i18n/i18n.dart';

class PaymentConfirmationWidget extends StatelessWidget {
  const PaymentConfirmationWidget({
    Key? key,
    required this.amount,
    required this.currencyFiat,
    required this.remainingAmount,
  }) : super(key: key);
  final String amount;
  final String currencyFiat;
  final String remainingAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Confirm Payment Info'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
          Divider(
            height: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 16),
              ),
              Text(
                '$amount $currencyFiat',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining Loan Amount'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 16),
              ),
              Text(
                '$remainingAmount $currencyFiat',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'You will have to enter your PIN to confirm this payment'.tr(),
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final password = await showPinConfirmationSheet(context);
              log(password.toString());
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
}

Future<bool?> showPaymentConfirmationSheet(
  BuildContext context, {
  required double amount,
  required String currencyFiat,
  required double remainingAmount,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => PaymentConfirmationWidget(
      amount: Formatter.formatMoney(amount),
      currencyFiat: currencyFiat,
      remainingAmount: Formatter.formatMoney(remainingAmount),
    ),
  );
  return false;
}
