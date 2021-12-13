import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/screen_size.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({Key? key}) : super(key: key);
  static const String routeName = '/loan-application';

  @override
  _LoanApplicationScreenState createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  double? _loanAmount;
  late LoanTypeProvider _loanTypeProvider;
  int _selectedCurrencyIndex = 0;
  int _selectedLoanTypeIndex = 0;
  int _selectedDurationInDays = 61;
  String? _selectedPurpose;

  @override
  void initState() {
    super.initState();
    _loanTypeProvider = LoanTypeProvider()
      ..getLoanTypes()
      ..addListener(_loanApplicationListener);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanTypeProvider,
      builder: (context, _) {
        return Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                title: const Text(
                  'Apply for a loan',
                ),
              ),
              body: Consumer<LoanTypeProvider>(
                builder: (context, loanTypeProvider, _) {
                  if (loanTypeProvider.errorMessage != null) {
                    return const Center(
                      child: Text(
                        'Some error occurred while fetching Loan Type Details',
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
                            onSelection: (value) {
                              setState(() {
                                _selectedCurrencyIndex = 0;
                                _selectedLoanTypeIndex = value;
                              });
                            },
                            selectedIndex: _selectedLoanTypeIndex,
                          ),
                          LoanCurrencyPicker(
                            currencies: _hasLoanTypes()
                                ? loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies
                                : [],
                            loading: loanTypeProvider.loading,
                            onChanged: (value) {
                              setState(() {
                                _selectedCurrencyIndex = value;
                                _loanAmount = loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies[_selectedCurrencyIndex]
                                    .minLoanAmount
                                    .toDouble();
                              });
                            },
                            selectedIndex: _selectedCurrencyIndex,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          LoanDurationPicker(
                            durationInDays: _selectedDurationInDays,
                            loading: loanTypeProvider.loading,
                            maxDurationInDays: _hasLoanTypes()
                                ? loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .maxDuration
                                : null,
                            minDurationInDays: _hasLoanTypes()
                                ? loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .minDuration
                                : null,
                            onChanged: (selectedDays) {
                              setState(() {
                                _selectedDurationInDays = selectedDays;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          LoanAmountPicker(
                            fiatCode: _hasLoanTypes()
                                ? loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies[_selectedCurrencyIndex]
                                    .currencyId!
                                    .fiatCode
                                : null,
                            interestRate: _hasLoanTypes()
                                ? loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .interestRate
                                    .toDouble()
                                : null,
                            loading: loanTypeProvider.loading,
                            loanAmount: _loanAmount,
                            maxAmount: _hasLoanTypes()
                                ? loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies[_selectedCurrencyIndex]
                                    .maxLoanAmount
                                    .toDouble()
                                : null,
                            minAmount: _hasLoanTypes()
                                ? loanTypeProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies[_selectedCurrencyIndex]
                                    .minLoanAmount
                                    .toDouble()
                                : null,
                            onChanged: (selectedAmount) {
                              setState(() {
                                _loanAmount = selectedAmount;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          LoanPurposePicker(
                            loading: loanTypeProvider.loading,
                            onChanged: (value) {
                              setState(() {
                                _selectedPurpose = value;
                              });
                            },
                            // TODO(Yabsra): fix this monstrosity
                            purposeList: _hasLoanTypes()
                                ? loanTypeProvider
                                        .loanTypes[_selectedLoanTypeIndex]
                                        .purpose ??
                                    []
                                : [],
                            selectedPurpose: _selectedPurpose,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TOCConfirmation(),
                          ElevatedButton(
                            onPressed: _canSubmit() ? _onSubmit : null,
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
              ),
            );
          },
        );
      },
    );
  }

  bool _canSubmit() {
    return _loanTypeProvider.canShowTypes &&
        _loanAmount != null &&
        _selectedPurpose != null;
  }

  Future<void> _onSubmit() async {
    final success = await showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      builder: (context) => LoanConfirmationWidget(
        amount: _loanAmount!,
        durationDays: _selectedDurationInDays,
        loanType: _loanTypeProvider.loanTypes[_selectedLoanTypeIndex],
        purpose: _selectedPurpose!,
        selectedCurrency: _loanTypeProvider.loanTypes[_selectedLoanTypeIndex]
            .currencies[_selectedCurrencyIndex],
      ),
    );
    if (success) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  bool _hasLoanTypes() {
    return _loanTypeProvider.loanTypes.isNotEmpty;
  }

  void _loanApplicationListener() {
    if (_loanTypeProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_loanTypeProvider.errorMessage!),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    if (_loanTypeProvider.loanTypes.isNotEmpty) {
      setState(() {
        _loanAmount = _loanTypeProvider.loanTypes[_selectedLoanTypeIndex]
            .currencies[_selectedCurrencyIndex].minLoanAmount
            .toDouble();
      });
    }
  }
}

class TOCConfirmation extends StatelessWidget {
  const TOCConfirmation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'By clicking on the'.tr(),
              style: Theme.of(context).textTheme.caption,
            ),
            TextSpan(
              text: ' ${'Submit Button'.tr()} ',
              style: Theme.of(context).textTheme.button,
            ),
            TextSpan(
              text: 'below, I hereby agree to and accept the following terms '
                      'and conditions governing my loan as stated in the'
                  .tr(),
              style: Theme.of(context).textTheme.caption,
            ),
            TextSpan(
              text: 'Terms and Conditions.'.tr(),
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
      ),
    );
  }
}
