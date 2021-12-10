import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';
import 'package:loan_app/i18n/i18n.dart';

class PaymentDetailCard extends StatelessWidget {
  const PaymentDetailCard({
    Key? key,
    required this.currencyFiat,
    required this.payment,
  }) : super(key: key);
  final String currencyFiat;
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Formatter.formatDate(
              DateTime.parse(payment.createdAt),
            ),
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.75,
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 2.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 0.75,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$currencyFiat ',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: Formatter.formatMoney(
                            payment.paymentAmount.toDouble(),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
