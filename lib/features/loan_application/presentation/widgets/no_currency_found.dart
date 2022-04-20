import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_application/presentation/analytics/analytics.dart';
import 'package:loan_app/i18n/i18n.dart';

class NoCurrencyFound extends StatelessWidget {
  const NoCurrencyFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No currencies available on your Leaf Wallet Account'.tr(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: Text('Add Currencies to Your Wallet'.tr()),
          onPressed: () {
            LoanApplicationAnalytics.addCurrencyTapped();
            _launchApp();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchApp() async {
    await ExternalLinks.launchApp();
  }
}
