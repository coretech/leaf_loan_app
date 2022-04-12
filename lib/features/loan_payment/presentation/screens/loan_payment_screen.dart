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
  double amount = 0;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController()
      ..addListener(() {
        setState(() {
          amount = double.tryParse(_amountController.text) ?? 0;
        });
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
                          _buildErrorWidget(loanPaymentProvider, context),
                        if (loanPaymentProvider.wallets.isNotEmpty)
                          LeafBalanceWidget(
                            balance: _getBalance(loanPaymentProvider.wallets),
                            currencyFiat: widget.loan.currency.fiatCode,
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

  Widget _buildErrorWidget(
    LoanPaymentProvider loanPaymentProvider,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            loanPaymentProvider.walletErrorMessage!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton.icon(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.error,
            ),
            label: Text(
              'Retry'.tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            onPressed: () async {
              await loanPaymentProvider.getWallet();
            },
          ),
        ],
      ),
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
                text: '${widget.loan.currency.fiatCode} ',
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
            prefixText: '${widget.loan.currency.fiatCode} ',
            prefixStyle: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            suffixIcon: _buildMaxButton(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: _validateAmount,
        ),
        if (_validateAmount(_amountController.text) == null)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              'You will have {1} {2} left to pay after this payment'.tr(
                values: {
                  '1': Formatter.formatMoney(_getRemaining()),
                  '2': widget.loan.currency.fiatCode,
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
        'Pay for your {1}'.tr(values: {'1': widget.loan.loanType}),
      ),
    );
  }

  Widget _buildMaxButton() {
    return TextButton(
      child: Text(
        'Max'.tr(),
      ),
      onPressed: () {
        _amountController.text = widget.loan.remainingAmount.toString();
        amount = widget.loan.remainingAmount;
      },
    );
  }

  Future<void> _onPay() async {
    LoanPaymentAnalytics.loanPaymentPayButtonTapped();
    if (widget.loan.remainingAmount - amount < 0.01) {
      amount = widget.loan.remainingAmount;
    }
    final paid = await showPaymentConfirmationSheet(
      context,
      amount: amount,
      loan: widget.loan,
      loanPaymentProvider: _loanPaymentProvider,
      remainingAmount: _getRemaining(),
    );
    if (paid != null && paid) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Payment successfully completed!'.tr(),
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
    return widget.loan.remainingAmount - amount;
  }

  double _getBalance(List<Wallet> wallets) {
    try {
      final activeCurrency = wallets.firstWhere(
        (wallet) => wallet.currency.fiatCode == widget.loan.currency.fiatCode,
      );
      balance = activeCurrency.balance;
      return activeCurrency.balance;
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
