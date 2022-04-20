import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/presentation/presentation.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class FormContentA extends StatelessWidget {
  const FormContentA({
    Key? key,
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

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
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
                  currencies: hasLoanTypes ? selectedLoanType!.currencies : [],
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
                  maxDurationInDays:
                      hasLoanTypes ? selectedLoanType!.maxDuration : null,
                  minDurationInDays:
                      hasLoanTypes ? selectedLoanType!.minDuration : null,
                  onChanged: onDurationInDaysSelected,
                ),
                const SizedBox(
                  height: 5,
                ),
                LoanAmountPicker(
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
                ),
                const SizedBox(
                  height: 5,
                ),
                LoanPurposePicker(
                  loading: loanTypeProvider.loading,
                  onChanged: onPurposeSelected,
                  purposeList: hasLoanTypes
                      ? loanTypeProvider
                          .loanTypes[selectedLoanTypeIndex].purpose
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
                  child: Text(
                    'Submit'.tr(),
                    style: const TextStyle(fontSize: 18),
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
