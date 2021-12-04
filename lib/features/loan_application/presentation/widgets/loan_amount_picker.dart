import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanAmountPicker extends StatelessWidget {
  const LoanAmountPicker({
    Key? key,
    required this.fiatCode,
    required this.interestRate,
    required this.loading,
    required this.loanAmount,
    required this.maxAmount,
    required this.minAmount,
    required this.onChanged,
  }) : super(key: key);
  final String? fiatCode;
  final double? interestRate;
  final bool loading;
  final double? loanAmount;
  final double? maxAmount;
  final double? minAmount;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Choose the loan amount'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                    ' sed do eiusmod tempor incididunt ut labore et dolore '
                    'magna'
                .tr(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        if (!loading)
          Slider(
            divisions: (maxAmount! - minAmount!).toInt() + 1,
            label: '${Formatter.formatMoney(loanAmount ?? minAmount!)}'
                ' ${fiatCode!}',
            max: maxAmount!,
            min: minAmount!,
            onChanged: !loading ? _onValueChanged : null,
            value: loanAmount ?? minAmount!,
          )
        else
          Padding(
            padding: const EdgeInsets.all(10),
            child: ShimmerBox(width: ScreenSize.of(context).width, height: 25),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: _getAmountLabels(context),
        ),
        const SizedBox(
          height: 20,
        ),
        if (!loading)
          Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      '${Formatter.formatMoney(loanAmount ?? minAmount!)}'
                      ' $fiatCode',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Amount'.tr(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 20,
                  spacing: 40,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${_getInterest()} $fiatCode',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text('${'Interest'.tr()} (${interestRate ?? 0}%)'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${_getTotal()}'
                          ' $fiatCode',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text('Total Due'.tr()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _getAmountLabels(BuildContext context) {
    if (loading) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ShimmerBox(
              width: 100,
              height: 40,
            ),
            ShimmerBox(
              width: 100,
              height: 40,
            ),
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${minAmount!} ${fiatCode!}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${maxAmount!} ${fiatCode!}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  void _onValueChanged(double value) {
    onChanged(value);
  }

  String _getTotal() {
    final amount = loanAmount ?? minAmount!;
    return Formatter.formatMoney(
      amount * (1 + ((interestRate ?? 0) / 100)),
    );
  }

  String _getInterest() {
    return Formatter.formatMoney(
      (loanAmount ?? minAmount!) * (interestRate! / 100),
    );
  }
}
