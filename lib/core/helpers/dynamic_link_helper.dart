import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:loan_app/core/domain/value_objects/value_objects.dart';
import 'package:loan_app/features/loan_history/ioc/ioc.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';

class DynamicLinkHelper {
  DynamicLinkHelper({
    required this.navigator,
  });

  final GlobalKey<NavigatorState> navigator;

  Future<void> onLink(DynamicLinkData linkData) async {
    if (linkData.link.queryParameters['path'] ==
        LoanPaymentScreen.routeName.replaceAll('/', '')) {
      final activeLoanResult =
          await LoanHistoryIOC.loanHistoryRepo.getActiveLoan();
      activeLoanResult.fold(
        (error) => null,
        (activeLoan) {
          navigator.currentState?.pushNamed(
            LoanPaymentScreen.routeName,
            arguments: LoanPaymentScreenArguments(loan: activeLoan),
          );
        },
      );
    }
  }
}
