import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/presentation.dart';

import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/features.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.currencyFiat,
    required this.payment,
  }) : super(key: key);
  final String currencyFiat;
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return PaymentDetailCard(
      currencyFiat: currencyFiat,
      payment: payment,
    );
  }

  static Widget shimmer(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(
            height: 12.5,
            width: 100,
          ),
          const SizedBox(height: 5),
          ShimmerBox(
            height: 50,
            width: ScreenSize.of(context).width,
          ),
        ],
      ),
    );
  }
}
