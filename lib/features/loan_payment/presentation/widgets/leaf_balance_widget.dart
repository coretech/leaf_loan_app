import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/i18n/i18n.dart';

class LeafBalanceWidget extends StatelessWidget {
  const LeafBalanceWidget({
    Key? key,
    required this.currencyFiat,
    required this.balance,
  }) : super(key: key);
  final String currencyFiat;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${'Your {1} balance on Leaf Wallet is'.tr(
            values: {'1': currencyFiat},
          )} ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$currencyFiat ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: Formatter.formatMoney(balance),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
