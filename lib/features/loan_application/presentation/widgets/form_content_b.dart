import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/presentation/presentation.dart';
import 'package:provider/provider.dart';

class FormContentB extends StatelessWidget {
  const FormContentB({
    Key? key,
    required this.hasLoanTypes,
    required this.selectedCurrencyIndex,
    required this.selectedLoanTypeIndex,
    required this.selectedDurationInDays,
    this.selectedPurpose,
    this.loanAmount,
    required this.onPurposeSelected,
    required this.onLoanAmountChanged,
    required this.onLoanTypeSelected,
    required this.onCurrencySelected,
    required this.onDurationInDaysSelected,
    required this.onSubmitPressed,
    required this.controller,
  }) : super(key: key);
  final bool hasLoanTypes;
  final int selectedCurrencyIndex;
  final int selectedLoanTypeIndex;
  final int selectedDurationInDays;
  final String? selectedPurpose;
  final double? loanAmount;
  final ValueChanged<String> onPurposeSelected;
  final ValueChanged<double> onLoanAmountChanged;
  final ValueChanged<int> onLoanTypeSelected;
  final ValueChanged<int> onCurrencySelected;
  final ValueChanged<int> onDurationInDaysSelected;
  final VoidCallback onSubmitPressed;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanTypeProvider>(
      builder: (context, loanTypeProvider, _) {
        return PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            LoanTypeSelection(
              loading: loanTypeProvider.loading,
              loanTypes: loanTypeProvider.loanTypes,
              onSelection: onLoanTypeSelected,
              selectedIndex: selectedLoanTypeIndex,
            ),
            LoanCurrencyPicker(
              currencies: hasLoanTypes
                  ? loanTypeProvider.loanTypes[selectedLoanTypeIndex].currencies
                  : [],
              loading: loanTypeProvider.loading,
              onChanged: onCurrencySelected,
              selectedIndex: selectedCurrencyIndex,
            ),
            LoanDurationPicker(
              durationInDays: selectedDurationInDays,
              loading: loanTypeProvider.loading,
              maxDurationInDays: hasLoanTypes
                  ? loanTypeProvider
                      .loanTypes[selectedLoanTypeIndex].maxDuration
                  : null,
              minDurationInDays: hasLoanTypes
                  ? loanTypeProvider
                      .loanTypes[selectedLoanTypeIndex].minDuration
                  : null,
              onChanged: onDurationInDaysSelected,
            ),
            LoanAmountPicker(
              fiatCode: hasLoanTypes
                  ? loanTypeProvider.loanTypes[selectedLoanTypeIndex]
                      .currencies[selectedCurrencyIndex].currencyId!.fiatCode
                  : null,
              interestRate: hasLoanTypes
                  ? loanTypeProvider
                      .loanTypes[selectedLoanTypeIndex].interestRate
                      .toDouble()
                  : null,
              loading: loanTypeProvider.loading,
              loanAmount: loanAmount ??
                  (hasLoanTypes
                      ? loanTypeProvider.loanTypes[selectedLoanTypeIndex]
                          .currencies[selectedCurrencyIndex].maxLoanAmount
                          .toDouble()
                      : 0),
              maxAmount: hasLoanTypes
                  ? loanTypeProvider.loanTypes[selectedLoanTypeIndex]
                      .currencies[selectedCurrencyIndex].maxLoanAmount
                      .toDouble()
                  : null,
              minAmount: hasLoanTypes
                  ? loanTypeProvider.loanTypes[selectedLoanTypeIndex]
                      .currencies[selectedCurrencyIndex].minLoanAmount
                      .toDouble()
                  : null,
              onChanged: onLoanAmountChanged,
            ),
            LoanPurposePicker(
              loading: loanTypeProvider.loading,
              onChanged: onPurposeSelected,
              // TODO(Yabsra): fix this monstrosity
              purposeList: hasLoanTypes
                  ? loanTypeProvider.loanTypes[selectedLoanTypeIndex].purpose ??
                      []
                  : [],
              selectedPurpose: selectedPurpose,
            ),
          ],
        );
      },
    );
  }
}
