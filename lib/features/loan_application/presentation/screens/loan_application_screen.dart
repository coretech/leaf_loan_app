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
  final String _currentCurrency = 'RWF';
  String? _selectedPurpose;

  double? _loanAmount;

  int _seletedDurationInDays = 61;

  late LoanApplicationProvider _loanApplicationProvider;

  @override
  void initState() {
    super.initState();
    _loanApplicationProvider = LoanApplicationProvider()
      ..getLoanTypes()
      ..addListener(() {
        if (_loanApplicationProvider.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_loanApplicationProvider.errorMessage!),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoanApplicationProvider>(
      create: (_) => _loanApplicationProvider,
      builder: (context, _) {
        return Builder(
          builder: (context) {
            return Consumer<LoanApplicationProvider>(
              builder: (context, loanApplicationProvider, _) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    title: const Text(
                      'Apply for a loan',
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoanTypeSelection(
                            onSelection: (value) {},
                          ),
                          LoanCurrencyPicker(
                            currencies: loanApplicationProvider
                                    .selectedLoanType?.currencies ??
                                [],
                            onChanged: (value) {
                              loanApplicationProvider
                                  .setSelectedCurrency(value);
                              setState(() {
                                _loanAmount = null;
                              });
                            },
                            selectedCurrency: _currentCurrency,
                            selectedIndex:
                                loanApplicationProvider.selectedCurrencyIndex,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          LoanDurationPicker(
                            durationInDays: _seletedDurationInDays,
                            loading: loanApplicationProvider.loading,
                            maxDurationInDays: loanApplicationProvider
                                .selectedLoanType?.maxDuration,
                            minDurationInDays: loanApplicationProvider
                                .selectedLoanType?.minDuration,
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
                            fiatCode: loanApplicationProvider
                                .selectedCurrency?.currencyId.fiatCode,
                            interestRate: loanApplicationProvider
                                .selectedLoanType?.interestRate
                                .toDouble(),
                            loading: loanApplicationProvider.loading,
                            loanAmount: _loanAmount,
                            maxAmount: loanApplicationProvider
                                .selectedCurrency?.maxLoanAmount
                                .toDouble(),
                            minAmount: loanApplicationProvider
                                .selectedCurrency?.minLoanAmount
                                .toDouble(),
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
                            purposeList: loanApplicationProvider
                                    .selectedLoanType?.purpose ??
                                [],
                            selectedPurpose: _selectedPurpose,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TOCConfirmation(),
                          ElevatedButton(
                            onPressed: !loanApplicationProvider.loading
                                ? _onSubmit
                                : null,
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
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _onSubmit() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => const ConfirmationWidget(
        amount: '1000',
        amountDue: '1100',
        interestRate: '10%',
        purpose: 'Some Purpose',
        typeName: 'Personal',
        dueDate: 'January 1, 2020',
      ),
    );
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
