import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanDetailAppBar extends StatelessWidget {
  const LoanDetailAppBar({
    Key? key,
    required this.dueDate,
    required this.paidAmount,
    required this.status,
    required this.totalAmount,
  }) : super(key: key);
  final DateTime dueDate;
  final double paidAmount;
  final LoanStatus status;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      bottom: _getRemainingAmount(context),
      backgroundColor: _getBackgroundColor(context),
      centerTitle: true,
      foregroundColor: status == LoanStatus.pending
          ? Theme.of(context).colorScheme.onSurface
          : Theme.of(context).colorScheme.onPrimary,
      floating: true,
      forceElevated: true,
      pinned: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('[Category X] ${'Loan'.tr()}'),
          if (status != LoanStatus.pending) const Spacer(),
          if (status != LoanStatus.pending)
            Text(
              '${_getRemainingDays()} ${'days remaining'.tr()}',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).canvasColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
        ],
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (status != LoanStatus.pending) {
      return Theme.of(context).colorScheme.secondary.withRed(210).withBlue(55);
    }
  }

  AppBar? _getRemainingAmount(context) {
    if (status != LoanStatus.pending) {
      return AppBar(
        actions: [
          if (status != LoanStatus.pending)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: PayButton.labeled(
                  context: context,
                  label: 'Pay'.tr(),
                  mini: true,
                  onTap: () {
                    log('pay on loan detail app bar tapped');
                    Navigator.of(context)
                        .pushNamed(LoanPaymentScreen.routeName);
                  },
                ),
              ),
            )
        ],
        backgroundColor: _getBackgroundColor(context),
        centerTitle: true,
        foregroundColor: status == LoanStatus.pending
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                text: '${'Remaining amount'.tr()}\n',
              ),
              TextSpan(
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                text: 'RWF ',
              ),
              TextSpan(
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
                text: Formatter.formatMoney(totalAmount - paidAmount),
              )
            ],
          ),
        ),
      );
    } else {
      return AppBar(
        backgroundColor: _getBackgroundColor(context),
        centerTitle: true,
        elevation: 0,
        title: Text('Completely Paid'.tr()),
      );
    }
  }

  int _getRemainingDays() {
    return dueDate.difference(DateTime.now()).inDays;
  }
}
