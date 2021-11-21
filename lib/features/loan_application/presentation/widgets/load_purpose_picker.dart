import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';

class LoanPurposePicker extends StatefulWidget {
  const LoanPurposePicker({
    Key? key,
    required this.selectedPurpose,
    required this.onChanged,
  }) : super(key: key);
  final String selectedPurpose;
  final ValueChanged<String> onChanged;

  @override
  _LoanPurposePickerState createState() => _LoanPurposePickerState();
}

class _LoanPurposePickerState extends State<LoanPurposePicker> {
  // a list of loan purposes
  final List<String> _loanPurposes = <String>[
    'Home Improvement',
    'Car Payment',
    'Debt Consolidation',
    'Education',
    'Emergency',
    'Entertainment',
    'Furniture',
    'Medical',
    'Other',
    'Vacation',
    'Wedding',
  ];

  @override
  Widget build(BuildContext context) {
    //a bottom sheet that shows a list of loan purposes and allows the
    // user to select one
    // a button that opens a bottom modal sheet
    return ElevatedButton.icon(
      icon: const Icon(Icons.inventory_outlined),
      label: const Text(
        'Select loan purpose',
        style: TextStyle(fontSize: 18),
      ),
      onPressed: () async {
        final purpose = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                    child: Text(
                      'Loan Purpose',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _loanPurposes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          selected:
                              _loanPurposes[index] == widget.selectedPurpose,
                          title: Text(_loanPurposes[index]),
                          onTap: () {
                            Navigator.pop(context, _loanPurposes[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
        if (purpose != null) {
          widget.onChanged(purpose);
        }
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        fixedSize: MaterialStateProperty.all(
          Size(
            ScreenSize.of(context).width - 40,
            50,
          ),
        ),
      ),
    );
  }
}
