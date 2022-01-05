import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/presentation/presentation.dart';
import 'package:provider/provider.dart';

class FormContentA extends StatelessWidget {
  const FormContentA({
    Key? key,
    required this.hasLoanTypes,
    required this.selectedCurrencyIndex,
    required this.selectedLoanTypeIndex,
    required this.selectedDurationInDays,
    this.selectedPurpose,
    required this.loanAmount,
    required this.onPurposeSelected,
    required this.onLoanAmountChanged,
    required this.onLoanTypeSelected,
    required this.onCurrencySelected,
    required this.onDurationInDaysSelected,
    required this.onSubmitPressed,
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

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanTypeProvider>(
      builder: (context, loanTypeProvider, _) {
        if (loanTypeProvider.errorMessage != null) {
          return Center(
            child: CustomErrorWidget(
              message: loanTypeProvider.errorMessage!,
              onRetry: loanTypeProvider.getLoanTypes,
            ),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoanTypeSelection(
                  loading: loanTypeProvider.loading,
                  loanTypes: loanTypeProvider.loanTypes,
                  onSelection: onLoanTypeSelected,
                  selectedIndex: selectedLoanTypeIndex,
                ),
                LoanCurrencyPicker(
                  currencies: hasLoanTypes
                      ? loanTypeProvider
                          .loanTypes[selectedLoanTypeIndex].currencies
                      : [],
                  loading: loanTypeProvider.loading,
                  onChanged: onCurrencySelected,
                  selectedIndex: selectedCurrencyIndex,
                ),
                const SizedBox(
                  height: 5,
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
                const SizedBox(
                  height: 5,
                ),
                LoanAmountPicker(
                  fiatCode: hasLoanTypes
                      ? loanTypeProvider
                          .loanTypes[selectedLoanTypeIndex]
                          .currencies[selectedCurrencyIndex]
                          .currencyId!
                          .fiatCode
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
                const SizedBox(
                  height: 5,
                ),
                LoanPurposePicker(
                  loading: loanTypeProvider.loading,
                  onChanged: onPurposeSelected,
                  // TODO(Yabsra): fix this monstrosity
                  purposeList: hasLoanTypes
                      ? loanTypeProvider
                              .loanTypes[selectedLoanTypeIndex].purpose ??
                          []
                      : [],
                  selectedPurpose: selectedPurpose,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TOCConfirmation(),
                ElevatedButton(
                  onPressed: onSubmitPressed,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(
                        ScreenSize.of(context).width - 40,
                        50,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
