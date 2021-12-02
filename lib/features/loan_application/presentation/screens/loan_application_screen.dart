import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/screen_size.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:provider/provider.dart';

/* cSpell:disable */
class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({Key? key}) : super(key: key);
  static const String routeName = '/loan-application';

  @override
  _LoanApplicationScreenState createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  double? _loanAmount;
  late LoanApplicationProvider _loanApplicationProvider;
  int _selectedCurrencyIndex = 0;
  int _selectedLoanTypeIndex = 0;
  int _seletedDurationInDays = 61;
  String? _selectedPurpose;

  @override
  void initState() {
    super.initState();
    _loanApplicationProvider = LoanApplicationProvider()
      ..getLoanTypes()
      ..addListener(_loanApplicationListener);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoanApplicationProvider>(
      create: (_) => _loanApplicationProvider,
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
              body: Consumer<LoanApplicationProvider>(
                builder: (context, loanApplicationProvider, _) {
                  if (loanApplicationProvider.errorMessage != null) {
                    return const Center(
                      child: Text(
                        'Some error occured while fetching Loan Type Details',
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
                            loading: loanApplicationProvider.loading,
                            loanTypes: loanApplicationProvider.loanTypes,
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
                                ? loanApplicationProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies
                                : [],
                            loading: loanApplicationProvider.loading,
                            onChanged: (value) {
                              setState(() {
                                _selectedCurrencyIndex = value;
                                _loanAmount = loanApplicationProvider
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
                            durationInDays: _seletedDurationInDays,
                            loading: loanApplicationProvider.loading,
                            maxDurationInDays: _hasLoanTypes()
                                ? loanApplicationProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .maxDuration
                                : null,
                            minDurationInDays: _hasLoanTypes()
                                ? loanApplicationProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .minDuration
                                : null,
                            onChanged: (selectedDays) {
                              setState(() {
                                _seletedDurationInDays = selectedDays;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          LoanAmountPicker(
                            fiatCode: _hasLoanTypes()
                                ? loanApplicationProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies[_selectedCurrencyIndex]
                                    .currencyId
                                    .fiatCode
                                : null,
                            interestRate: _hasLoanTypes()
                                ? loanApplicationProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .interestRate
                                    .toDouble()
                                : null,
                            loading: loanApplicationProvider.loading,
                            loanAmount: _loanAmount,
                            maxAmount: _hasLoanTypes()
                                ? loanApplicationProvider
                                    .loanTypes[_selectedLoanTypeIndex]
                                    .currencies[_selectedCurrencyIndex]
                                    .maxLoanAmount
                                    .toDouble()
                                : null,
                            minAmount: _hasLoanTypes()
                                ? loanApplicationProvider
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
                            loading: loanApplicationProvider.loading,
                            onChanged: (value) {
                              setState(() {
                                _selectedPurpose = value;
                              });
                            },
                            purposeList: _hasLoanTypes()
                                ? loanApplicationProvider
                                    .loanTypes[_selectedLoanTypeIndex].purpose
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
    return _loanApplicationProvider.canShowTypes &&
        _loanAmount != null &&
        _selectedPurpose != null;
  }

  Future<void> _onSubmit() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => LoanConfirmationWidget(
        amount: _loanAmount!,
        durationDays: _seletedDurationInDays,
        loanType: _loanApplicationProvider.loanTypes[_selectedLoanTypeIndex],
        purpose: _selectedPurpose!,
        selectedCurrency: _loanApplicationProvider
            .loanTypes[_selectedLoanTypeIndex]
            .currencies[_selectedCurrencyIndex],
      ),
    );
  }

  bool _hasLoanTypes() {
    return _loanApplicationProvider.loanTypes.isNotEmpty;
  }

  void _loanApplicationListener() {
    if (_loanApplicationProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_loanApplicationProvider.errorMessage!),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    if (_loanApplicationProvider.loanTypes.isNotEmpty) {
      setState(() {
        _loanAmount = _loanApplicationProvider.loanTypes[_selectedLoanTypeIndex]
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
              text: 'By clicking on the ',
              style: Theme.of(context).textTheme.caption,
            ),
            TextSpan(
              text: 'Submit Button ',
              style: Theme.of(context).textTheme.button,
            ),
            TextSpan(
              text: 'below, I hereby agree to and accept the following'
                  ' terms and conditions governing my '
                  'loan that are stated in the ',
              style: Theme.of(context).textTheme.caption,
            ),
            TextSpan(
              text: 'Terms and Conditions.',
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
      ),
    );
  }
}
