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
  String _currentCurrency = 'KES';

  DateTime dueDate = DateTime.now().add(Duration(days: Random().nextInt(75)));

  double _loanAmount = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: Text(
          'Apply for a loan',
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("WIP"),
              LoanTypeSelector(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Loan Amount',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Slider(
                max: 100000,
                min: 50,
                divisions: 100000 - 50,
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
                    '100000 $_currentCurrency',
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
                          '${Formatter.formatMoney(_loanAmount * 0.1)} $_currentCurrency',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Text('Interest (10%)'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${Formatter.formatMoney(_loanAmount + (_loanAmount * 0.1))} $_currentCurrency',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Text('Total Due'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  label: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {},
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                    Size(
                      ScreenSize.of(context).width - 40,
                      50,
                    ),
                  )),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          LoanApplicationScreen(hasLoan: false),
                    ),
                  );
                },
                child: Text('Peek at the old one'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
