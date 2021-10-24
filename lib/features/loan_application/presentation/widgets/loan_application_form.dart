import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

class LoanApplicationForm extends StatefulWidget {
  const LoanApplicationForm({Key? key}) : super(key: key);

  @override
  _LoanApplicationFormState createState() => _LoanApplicationFormState();
}

class _LoanApplicationFormState extends State<LoanApplicationForm> {
  final _currencies = [
    'KES',
    'RWF',
    'UGS',
  ];

  final _reasons = [
    'Food',
    'Medical',
    'Personal',
    'Rent',
    'Shopping',
    'Transport',
  ];
  String _currentCurrency = 'KES';
  String? _currentReason;

  DateTime dueDate = DateTime.now().add(Duration(days: Random().nextInt(75)));

  double _loanAmount = 50;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Fill in the details below to apply for a loan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(
              endIndent: 40,
              indent: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'What is the loan for?',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: const EdgeInsets.all(5),
                    errorStyle: const TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'Please select a reason',
                  ),
                  isEmpty: _currentReason == null,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          _currentReason = newValue;
                        });
                      },
                      value: _currentReason,
                      items: _reasons.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'What is the currency you want to use?',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: const EdgeInsets.all(5),
                    errorStyle: const TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'Please select a currency',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: true,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            _currentCurrency = newValue;
                          });
                        }
                      },
                      value: _currentCurrency,
                      items: _currencies.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Duration',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 50,
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'For: ',
                            style: TextStyle(
                              color: Theme.of(context).unselectedWidgetColor,
                              fontSize: 16,
                            )),
                        TextSpan(
                          text:
                              '${dueDate.difference(DateTime.now()).inDays} days',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Due: ',
                            style: TextStyle(
                              color: Theme.of(context).unselectedWidgetColor,
                              fontSize: 16,
                            )),
                        TextSpan(
                          text: Formatter.formatDate(dueDate),
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Loan Amount',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Slider(
              max: 100000,
              min: 50,
              divisions: 100000 - 50,
              value: _loanAmount,
              label: '${Formatter.formatMoney(_loanAmount)} $_currentCurrency',
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
          ],
        ),
      ),
    );
  }
}
