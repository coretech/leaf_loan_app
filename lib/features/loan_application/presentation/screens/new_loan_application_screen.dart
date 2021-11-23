import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/screen_size.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/features.dart';

class NewLoanApplication extends StatefulWidget {
  const NewLoanApplication({Key? key}) : super(key: key);

  @override
  _NewLoanApplicationState createState() => _NewLoanApplicationState();
}

class _NewLoanApplicationState extends State<NewLoanApplication> {
  final String _currentCurrency = 'RWF';
  String _selectedPurpose = 'Home Improvement';

  DateTime dueDate = DateTime.now().add(Duration(days: Random().nextInt(75)));

  double _loanAmount = 50;
  LoanType _loanType = LoanType.personal;
  @override
  Widget build(BuildContext context) {
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
                onSelection: (value) {
                  setState(() {
                    _loanType = value;
                  });
                },
                selectedLoanType: _loanType,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Select a loan currency',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                  ' sed do eiusmod tempor incididunt ut labore et dolore magna',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              LoanCurrencyPicker(
                onChanged: (value) {},
                selectedCurrency: _currentCurrency,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Choose the loan duration',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                  ' sed do eiusmod tempor incididunt ut labore et dolore magna',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              const LoanDurationPicker(),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Choose the loan amount',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                  ' sed do eiusmod tempor incididunt ut labore et dolore magna',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Slider(
                max: 50000,
                min: 50,
                divisions: 50000 - 50,
                value: _loanAmount,
                label:
                    '${Formatter.formatMoney(_loanAmount)} $_currentCurrency',
                onChanged: (amount) {
                  setState(() {
                    _loanAmount = amount;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '50 $_currentCurrency',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '50000 $_currentCurrency',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 20,
                  spacing: 40,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${Formatter.formatMoney(_loanAmount * 0.1)}'
                          ' $_currentCurrency',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Text('Interest (10%)'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${Formatter.formatMoney(_getTotal(_loanAmount))}'
                          ' $_currentCurrency',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Text('Total Due'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Choose the loan purpose',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                  ' sed do eiusmod tempor incididunt ut labore et dolore magna',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              const SizedBox(height: 10),
              LoanPurposePicker(
                onChanged: (value) {
                  setState(() {
                    _selectedPurpose = value;
                  });
                },
                selectedPurpose: _selectedPurpose,
              ),
              const SizedBox(
                height: 20,
              ),
              const TOCConfirmation(),
              ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Loan application submitted'),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(
                      ScreenSize.of(context).width - 40,
                      50,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoanApplicationScreen(hasLoan: false),
                    ),
                  );
                },
                child: const Text('Peek at the old one'),
              )
            ],
          ),
        ),
      ),
    );
  }

  double _getTotal(double amount) {
    return amount * 1.1;
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
