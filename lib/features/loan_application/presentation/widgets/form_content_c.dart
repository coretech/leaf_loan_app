import 'package:flutter/material.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/core/presentation/widgets/widgets.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class FormContentC extends StatelessWidget {
  const FormContentC({
    Key? key,
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
        LoanType? selectedLoanType;
        final hasLoanTypes = loanTypeProvider.hasLoanTypes;
        if (hasLoanTypes) {
          selectedLoanType = loanTypeProvider.loanTypes[selectedLoanTypeIndex];
        }
        final hasCurrencies = selectedLoanType?.hasCurrencies ?? false;
        final hasLoanTypesAndCurrencies = hasCurrencies && hasLoanTypes;
        LoanCurrency? selectedCurrency;
        if (hasLoanTypesAndCurrencies) {
          selectedCurrency =
              selectedLoanType!.currencies[selectedCurrencyIndex];
        }

        if (loanTypeProvider.errorMessage != null || !hasLoanTypes) {
          return Center(
            child: CustomErrorWidget(
              message: loanTypeProvider.genericErrorMessage.tr(),
              onRetry: loanTypeProvider.getLoanTypes,
            ),
          );
        }
        if (!hasLoanTypesAndCurrencies) {
          return const Center(child: NoCurrencyFound());
        }
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
                      child: Text('Back'.tr()),
                    ),
                  if (details.currentStep < 4)
                    TextButton(
                      onPressed: onNextPressed,
                      child: Text('Next'.tr()),
                    ),
                  if (details.currentStep == 4)
                    ElevatedButton(
                      onPressed: onSubmitPressed,
                      child: Text('Submit'.tr()),
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
                currencies: hasLoanTypes ? selectedLoanType!.currencies : [],
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
                maxDurationInDays:
                    hasLoanTypes ? selectedLoanType!.maxDuration : null,
                minDurationInDays:
                    hasLoanTypes ? selectedLoanType!.minDuration : null,
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
                fiatCode: hasLoanTypesAndCurrencies
                    ? selectedCurrency!.fiatCode
                    : null,
                interestRate:
                    hasLoanTypes ? selectedLoanType!.interestRate : null,
                loading: loanTypeProvider.loading,
                loanAmount: loanAmount ??
                    (hasLoanTypesAndCurrencies
                        ? selectedCurrency!.maxLoanAmount
                        : 0),
                maxAmount: hasLoanTypesAndCurrencies
                    ? selectedCurrency!.maxLoanAmount
                    : null,
                minAmount: hasLoanTypesAndCurrencies
                    ? selectedCurrency!.minLoanAmount
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
                purposeList: hasLoanTypes ? selectedLoanType!.purpose : [],
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
