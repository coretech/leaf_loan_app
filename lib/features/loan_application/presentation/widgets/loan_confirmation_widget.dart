import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanConfirmationWidget extends StatefulWidget {
  const LoanConfirmationWidget({
    Key? key,
    required this.amount,
    required this.durationDays,
    required this.purpose,
    required this.selectedCurrency,
    required this.loanType,
  }) : super(key: key);
  final double amount;
  final int durationDays;
  final String purpose;
  final LoanCurrency selectedCurrency;
  final LoanType loanType;

  @override
  State<LoanConfirmationWidget> createState() => _LoanConfirmationWidgetState();
}

class _LoanConfirmationWidgetState extends State<LoanConfirmationWidget> {
  late LoanApplicationProvider _loanApplicationProvider;
  @override
  void initState() {
    super.initState();
    _loanApplicationProvider = LoanApplicationProvider()
      ..addListener(
        () {
          if (_loanApplicationProvider.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _loanApplicationProvider.errorMessage!,
                  maxLines: 3,
                ),
              ),
            );
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanApplicationProvider,
      builder: (context, _) {
        return WillPopScope(
          onWillPop: () async {
            return !_loanApplicationProvider.loading;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Confirm Loan Info'.tr(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(
                    height: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Loan Type'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.loanType.name,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Amount'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.selectedCurrency.fiatCode} '
                          '${Formatter.formatMoney(widget.amount)}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Interest Rate'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.loanType.interestRate}%',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Amount Due'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.selectedCurrency.fiatCode} '
                          '${Formatter.formatMoney(_getAmountDue())}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Due Date'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _getDueDate(context),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Loan Purpose'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.purpose,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You will have to enter your PIN '
                            'to confirm this loan request'
                        .tr(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 10),
                  Consumer<LoanApplicationProvider>(
                    builder: (context, loanApplicationProvider, __) {
                      return ElevatedButton(
                        onPressed: !loanApplicationProvider.loading
                            ? _confirmPinAndSubmitLoan
                            : null,
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
                            if (loanApplicationProvider.loading)
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  strokeWidth: 1,
                                ),
                              ),
                            if (loanApplicationProvider.loading)
                              const SizedBox(width: 10),
                            Text(
                              'Proceed'.tr(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double _getAmountDue() {
    return widget.amount + (widget.amount * widget.loanType.interestRate / 100);
  }

  String _getDueDate(BuildContext context) {
    final now = DateTime.now();
    final dueDate = now.add(Duration(days: widget.durationDays));
    return Formatter.formatDate(
      dueDate,
    );
  }

  Future<void> _confirmPinAndSubmitLoan() async {
    final pinCode = await showPinConfirmationSheet(context);
    if (pinCode != null) {
      await _loanApplicationProvider.apply(
        amount: widget.amount,
        currencyId: widget.selectedCurrency.id,
        duration: widget.durationDays,
        loanPurpose: widget.purpose,
        loanTypeId: widget.loanType.id,
        pinCode: pinCode,
      );
      LoanApplicationAnalytics.loanApplicationSubmitted();
      if (mounted) {
        Navigator.of(context)
            .pop(_loanApplicationProvider.errorMessage == null);
      }
    }
  }
}
