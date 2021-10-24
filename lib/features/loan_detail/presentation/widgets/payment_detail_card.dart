import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';


class PaymentDetailCard extends StatelessWidget {
  const PaymentDetailCard({
    Key? key,
    this.disbursement = false,
  }) : super(key: key);
  final bool disbursement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.25),
            blurRadius: 2.5,
            offset: const Offset(1, 2),
          )
        ],
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              Formatter.formatDateMini(
                DateTime.now().subtract(
                  Duration(
                    days: Random().nextInt(1000),
                  ),
                ),
              ),
              style:
                  Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 17),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                disbursement ? 'Disbursement' : 'Payment',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 17),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${Formatter.formatMoney(Random().nextDouble() * 100000)} RWF',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }
}
