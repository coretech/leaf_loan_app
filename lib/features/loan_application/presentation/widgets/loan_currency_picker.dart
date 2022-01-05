import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanCurrencyPicker extends StatelessWidget {
  const LoanCurrencyPicker({
    Key? key,
    required this.loading,
    required this.currencies,
    required this.selectedIndex,
    required this.onChanged,
    this.shouldShowTitle = true,
  }) : super(key: key);

  final bool loading;
  final List<Currency> currencies;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool shouldShowTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Select a loan currency'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Available currencies are those you use in your Leaf Wallet. '
                    'Leaf currently supports KES, RWF, and UGX.'
                .tr(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Container(
          height: 110,
          padding: const EdgeInsets.all(8),
          child: _buildCurrenciesList(),
        ),
      ],
    );
  }

  Widget _buildCurrenciesList() {
    if (currencies.isEmpty && !loading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No currencies available on your Leaf Wallet Account'.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: () {
              LoanApplicationAnalytics.addCurrencyTapped();
              _launchApp();
            },
            icon: const Icon(Icons.add),
            label: Text('Add Currencies to Your Wallet'.tr()),
          ),
        ],
      );
    }
    return ListView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: _getCurrencies(),
    );
  }

  List<Widget> _getCurrencies() {
    if (!loading) {
      final currencyCards = <Widget>[];
      for (var i = 0; i < currencies.length; i++) {
        final currency = currencies[i];
        final code = FlagUtil.getCode(currency.currencyId!.country);
        final flag = Flag.fromString(
          code?.toLowerCase() ?? 'rw',
          height: 25,
          width: 50,
        );
        currencyCards.add(
          CurrencyCard(
            currency: currency,
            flag: flag,
            index: i,
            onTap: onChanged,
            selectedIndex: selectedIndex,
          ),
        );
      }
      return currencyCards;
    } else {
      return List.filled(
        3,
        const ShimmerBox(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 90,
        ),
      );
    }
  }

  Future<void> _launchApp() async {
    await AppLinks.launchApp();
  }
}
