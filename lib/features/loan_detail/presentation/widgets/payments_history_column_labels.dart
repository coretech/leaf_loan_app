import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';

class PaymentsHistoryColumnLabels extends SliverPersistentHeaderDelegate {
  PaymentsHistoryColumnLabels();

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Text(
        'Transaction History'.tr(),
        style: Theme.of(context).textTheme.headline5?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }
}
