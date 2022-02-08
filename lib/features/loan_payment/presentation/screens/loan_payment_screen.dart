import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/widgets/widgets.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_payment/presentation/analytics/analytics.dart';
import 'package:loan_app/features/loan_payment/presentation/providers/loan_payment_provider.dart';
import 'package:loan_app/features/loan_payment/presentation/widgets/widgets.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanPaymentScreen extends StatefulWidget {
  const LoanPaymentScreen({
    Key? key,
    required this.loan,
  }) : super(key: key);
  static const routeName = '/loan-payment';
  final LoanData loan;

  @override
  _LoanPaymentScreenState createState() => _LoanPaymentScreenState();
}

class _LoanPaymentScreenState extends State<LoanPaymentScreen> {
  late TextEditingController _amountController;
  late LoanPaymentProvider _loanPaymentProvider;
  double balance = 0;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _loanPaymentProvider = LoanPaymentProvider()
      ..getWallet()
      ..addListener(_loanPaymentListener);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanPaymentProvider,
      builder: (context, _) {
        return Consumer<LoanPaymentProvider>(
          builder: (context, loanPaymentProvider, _) {
            return Scaffold(
              appBar: _buildAppBar(context),
              body: RefreshIndicator(
                onRefresh: () async {
                  await loanPaymentProvider.getWallet();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                        ),
                        _buildRemainingBalance(context),
                        Divider(
                          color: Theme.of(context).colorScheme.secondary,
                          endIndent: 50,
                          height: 30,
                          indent: 50,
                        ),
                        if (loanPaymentProvider.loading)
                          const ShimmerBox(
                            height: 50,
                            width: 125,
                          ),
                        if (loanPaymentProvider.walletErrorMessage != null)
                          Text(
                            loanPaymentProvider.walletErrorMessage!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        if (loanPaymentProvider.wallet != null)
                          LeafBalanceWidget(
                            balance: _getBalance(loanPaymentProvider.wallet!),
                            currencyFiat: widget.loan.currencyId!.fiatCode,
                          ),
                        const SizedBox(height: 20),
                        _buildTextFieldWithMessages(context),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.payment),
                          label: Text(
                            'Pay'.tr(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          onPressed:
                              _validateAmount(_amountController.text) == null
                                  ? _onPay
                                  : null,
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(
                                ScreenSize.of(context).width - 40,
                                50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRemainingBalance(BuildContext context) {
    return Column(
      children: [
        Text(
          '${'Your current remaining loan amount is'.tr()} ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${widget.loan.currencyId!.fiatCode} ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              TextSpan(
                text: Formatter.formatMoney(
                  widget.loan.remainingAmount,
                ),
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

  Widget _buildTextFieldWithMessages(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _amountController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            errorMaxLines: 3,
            labelText: 'Enter the amount you want to pay'.tr(),
            prefixText: '${widget.loan.currencyId!.fiatCode} ',
            prefixStyle: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          keyboardType: TextInputType.number,
          validator: _validateAmount,
        ),
        if (_validateAmount(_amountController.text) == null)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              'You will have {1} {2} left to pay after this payment'.tr(
                values: {
                  '1': Formatter.formatMoney(_getRemaining()),
                  '2': widget.loan.currencyId!.fiatCode,
                },
              ),
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      elevation: 0,
      foregroundColor: Theme.of(context).colorScheme.onBackground,
      title: Text(
        'Pay for your {1}'.tr(values: {'1': widget.loan.loanTypeId.name}),
      ),
    );
  }

  Future<void> _onPay() async {
    LoanPaymentAnalytics.loanPaymentPayButtonTapped();
    final paid = await showPaymentConfirmationSheet(
      context,
      amount: double.parse(_amountController.text),
      loan: widget.loan,
      loanPaymentProvider: _loanPaymentProvider,
      remainingAmount: _getRemaining(),
    );
    if (paid != null && paid) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Payment successfully completed!',
            ),
          ),
        );
      }
    }
  }

  String? _validateAmount(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter the amount you want to pay'.tr();
    }
    if (double.tryParse(value!) == null) {
      return 'Please enter a valid amount'.tr();
    }
    if (double.parse(value) > widget.loan.remainingAmount) {
      return 'Please enter an amount less than or equal to your '
              'remaining amount'
          .tr();
    }
    if (double.parse(value) > balance) {
      return 'Please enter an amount less than or equal to your '
              'Leaf Wallet balance'
          .tr();
    }
    return null;
  }

  double _getRemaining() {
    return widget.loan.remainingAmount - double.parse(_amountController.text);
  }

  double _getBalance(Wallet wallet) {
    try {
      final activeCurrency = wallet.walletDetail.firstWhere(
        (walletDetail) =>
            walletDetail.currencyId.fiatCode ==
            widget.loan.currencyId!.fiatCode,
      );
      // ignore: join_return_with_assignment
      balance = activeCurrency.balance;
      return balance;
    } catch (_) {
      return 0;
    }
  }

  void _loanPaymentListener() {
    if (_loanPaymentProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _loanPaymentProvider.errorMessage!,
            maxLines: 3,
          ),
        ),
      );
    }
  }
}
