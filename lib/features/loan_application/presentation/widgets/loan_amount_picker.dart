import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/presentation/analytics/analytics.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanAmountPicker extends StatefulWidget {
  const LoanAmountPicker({
    Key? key,
    required this.fiatCode,
    required this.interestRate,
    required this.loading,
    required this.loanAmount,
    required this.maxAmount,
    required this.minAmount,
    required this.onChanged,
    this.shouldShowTitle = true,
  }) : super(key: key);
  final String? fiatCode;
  final double? interestRate;
  final bool loading;
  final double loanAmount;
  final double? maxAmount;
  final double? minAmount;
  final ValueChanged<double> onChanged;
  final bool shouldShowTitle;

  @override
  State<LoanAmountPicker> createState() => _LoanAmountPickerState();
}

class _LoanAmountPickerState extends State<LoanAmountPicker> {
  late TextEditingController _amountController;
  final FocusNode _amountFocusNode = FocusNode();

  double get _sliderValue {
    if (widget.loanAmount < widget.minAmount!) {
      return widget.minAmount!;
    } else if (widget.loanAmount > widget.maxAmount!) {
      return widget.maxAmount!;
    } else {
      return widget.loanAmount;
    }
  }

  @override
  void initState() {
    log('initState', name: 'LoanAmountPicker');
    super.initState();
    _amountController = TextEditingController(
      text: widget.loanAmount.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(LoanAmountPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loanAmount != oldWidget.loanAmount &&
        !_amountFocusNode.hasFocus) {
      _amountController.text = widget.loanAmount.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.shouldShowTitle)
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
            'Please choose an amount within the range. You can use the '
                    'slider or the box to input the amount you want. '
                    'Interest will be automatically added and the total '
                    'will be displayed at the bottom.'
                .tr(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        if (!widget.loading)
          Slider(
            divisions: (widget.maxAmount! - widget.minAmount!).toInt() + 1,
            label: '${Formatter.formatMoney(widget.loanAmount)}'
                ' ${widget.fiatCode!}',
            max: widget.maxAmount!,
            min: widget.minAmount!,
            onChanged: !widget.loading ? _onValueChanged : null,
            onChangeEnd: (_) => LoanApplicationAnalytics.sliderUsed(),
            value: _sliderValue,
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
        if (!widget.loading)
          Center(
            child: Column(
              children: [
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
                          '${Formatter.formatMoney(widget.loanAmount)}'
                          ' ${widget.fiatCode}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'Amount'.tr(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${_getInterest()} ${widget.fiatCode}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          '${'Interest'.tr()} (${widget.interestRate ?? 0}%)',
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _amountController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorMaxLines: 3,
                          prefixText: '${widget.fiatCode} ',
                          prefixStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        focusNode: _amountFocusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (value) {
                          final amount = double.tryParse(value);
                          if (amount == null) {
                            widget.onChanged(widget.minAmount!);
                          } else {
                            widget.onChanged(amount);
                          }
                        },
                        onTap: LoanApplicationAnalytics.amountFieldUsed,
                        validator: (value) {
                          final amount = double.tryParse(value ?? '0');
                          if (amount == null || amount < widget.minAmount!) {
                            return 'Amount must be greater than or equal'
                                ' to ${widget.minAmount}!';
                          } else if (amount > widget.maxAmount!) {
                            return 'Amount must be less than or equal'
                                ' to ${widget.maxAmount}!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Text(
                      '${_getTotal()}'
                      ' ${widget.fiatCode}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text('Total'.tr()),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _getAmountLabels(BuildContext context) {
    if (widget.loading) {
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
          '${Formatter.formatMoney(widget.minAmount!)} ${widget.fiatCode!}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${Formatter.formatMoney(widget.maxAmount!)} ${widget.fiatCode!}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  void _onValueChanged(double value) {
    _amountFocusNode.unfocus();
    widget.onChanged(value);
  }

  String _getTotal() {
    final amount = widget.loanAmount;
    return Formatter.formatMoney(
      amount * (1 + ((widget.interestRate ?? 0) / 100)),
    );
  }

  String _getInterest() {
    return Formatter.formatMoney(
      (widget.loanAmount) * (widget.interestRate! / 100),
    );
  }
}
