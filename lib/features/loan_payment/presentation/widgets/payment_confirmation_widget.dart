import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_payment/presentation/analytics/analytics.dart';
import 'package:loan_app/features/loan_payment/presentation/providers/providers.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class PaymentConfirmationWidget extends StatefulWidget {
  const PaymentConfirmationWidget({
    Key? key,
    required this.amount,
    required this.loan,
    required this.loanPaymentProvider,
    required this.remainingAmount,
  }) : super(key: key);
  final double amount;
  final LoanData loan;
  final LoanPaymentProvider loanPaymentProvider;
  final double remainingAmount;

  @override
  State<PaymentConfirmationWidget> createState() =>
      _PaymentConfirmationWidgetState();
}

class _PaymentConfirmationWidgetState extends State<PaymentConfirmationWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.loanPaymentProvider,
      builder: (context, _) {
        return Consumer<LoanPaymentProvider>(
          builder: (context, loanPaymentProvider, _) {
            return SingleChildScrollView(
              child: Padding(
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
                          '${widget.loan.currency.fiatCode} '
                          '${Formatter.formatMoney(widget.amount)}',
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
                          '${widget.loan.currency.fiatCode} '
                          '${Formatter.formatMoney(widget.remainingAmount)}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'You will have to enter your PIN to confirm this payment'
                          .tr(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: loanPaymentProvider.paying ? null : _onSubmit,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (loanPaymentProvider.paying)
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.onPrimary,
                                strokeWidth: 1,
                              ),
                            ),
                          if (loanPaymentProvider.paying)
                            const SizedBox(width: 10),
                          Text(
                            'Proceed'.tr(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onSubmit() async {
    final password = await showPinConfirmationSheet(context);
    if (password != null) {
      await widget.loanPaymentProvider.payLoan(
        amount: widget.amount,
        currencyId: widget.loan.currency.id,
        loanId: widget.loan.id,
        password: password,
      );
      LoanPaymentAnalytics.loanPaymentSubmitted();
      if (widget.loanPaymentProvider.paid) {
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    }
  }
}

Future<bool?> showPaymentConfirmationSheet(
  BuildContext context, {
  required double amount,
  required LoanData loan,
  required double remainingAmount,
  required LoanPaymentProvider loanPaymentProvider,
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => PaymentConfirmationWidget(
      amount: amount,
      loan: loan,
      loanPaymentProvider: loanPaymentProvider,
      remainingAmount: remainingAmount,
    ),
  );
}
