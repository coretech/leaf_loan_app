import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class FormContentC extends StatelessWidget {
  const FormContentC({
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
    required this.onNextPressed,
    required this.onBackPressed,
    required this.currentStep,
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
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final int currentStep;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoanTypeProvider>(
      builder: (context, loanTypeProvider, _) {
        return Stepper(
          currentStep: currentStep,
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  if (details.currentStep > 0)
                    TextButton(
                      onPressed: onBackPressed,
                      child: const Text('Back'),
                    ),
                  if (details.currentStep < 4)
                    TextButton(
                      onPressed: onNextPressed,
                      child: const Text('Next'),
                    ),
                  if (details.currentStep == 4)
                    ElevatedButton(
                      onPressed: onSubmitPressed,
                      child: const Text('Submit'),
                    ),
                ],
              ),
            );
          },
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          steps: [
            Step(
              content: LoanTypeSelection(
                loading: loanTypeProvider.loading,
                loanTypes: loanTypeProvider.loanTypes,
                onSelection: onLoanTypeSelected,
                selectedIndex: selectedLoanTypeIndex,
                shouldShowTitle: false,
              ),
              isActive: currentStep == 0,
              title: Text(
                'Choose a loan type'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Step(
              content: LoanCurrencyPicker(
                currencies: hasLoanTypes
                    ? loanTypeProvider
                        .loanTypes[selectedLoanTypeIndex].currencies
                    : [],
                loading: loanTypeProvider.loading,
                onChanged: onCurrencySelected,
                selectedIndex: selectedCurrencyIndex,
                shouldShowTitle: false,
              ),
              title: Text(
                'Select a loan currency'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
              isActive: currentStep == 1,
            ),
            Step(
              content: LoanDurationPicker(
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
                shouldShowTitle: false,
              ),
              isActive: currentStep == 2,
              title: Text(
                'Choose the loan duration'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Step(
              content: LoanAmountPicker(
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
                shouldShowTitle: false,
              ),
              isActive: currentStep == 3,
              title: Text(
                'Choose the loan amount'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Step(
              content: LoanPurposePicker(
                loading: loanTypeProvider.loading,
                onChanged: onPurposeSelected,
                // TODO(Yabsra): fix this monstrosity
                purposeList: hasLoanTypes
                    ? loanTypeProvider
                            .loanTypes[selectedLoanTypeIndex].purpose ??
                        []
                    : [],
                selectedPurpose: selectedPurpose,
                shouldShowTitle: false,
              ),
              isActive: currentStep == 4,
              title: Text(
                'Choose the loan purpose'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        );
      },
    );
  }
}
