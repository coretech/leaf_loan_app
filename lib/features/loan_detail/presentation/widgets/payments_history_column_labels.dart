import 'package:flutter/material.dart';

class PaymentsHistoryColumnLabels extends SliverPersistentHeaderDelegate {
  PaymentsHistoryColumnLabels();

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.25),
                  blurRadius: 2.5,
                  offset: const Offset(1, 2),
                )
              ],
              color: Theme.of(context).colorScheme.primary,
            ),
            margin: const EdgeInsets.only(
              top: 5,
              left: 10,
            ),
            padding: const EdgeInsets.only(top: 7.5, left: 10, right: 15),
            child: Text(
              'Transaction History',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.25),
                  blurRadius: 2.5,
                  spreadRadius: 0.1,
                  offset: const Offset(1, 5),
                )
              ],
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            margin: const EdgeInsets.only(
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Action',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Amount',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
