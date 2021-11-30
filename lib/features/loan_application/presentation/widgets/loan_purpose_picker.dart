import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';

class LoanPurposePicker extends StatefulWidget {
  const LoanPurposePicker({
    Key? key,
    required this.loading,
    required this.onChanged,
    required this.purposeList,
    required this.selectedPurpose,
  }) : super(key: key);
  final bool loading;
  final ValueChanged<String> onChanged;
  final List<String> purposeList;
  final String? selectedPurpose;

  @override
  _LoanPurposePickerState createState() => _LoanPurposePickerState();
}

class _LoanPurposePickerState extends State<LoanPurposePicker> {
  final List<String> purposeList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            ' sed do eiusmod tempor incididunt ut labore et dolore'
            ' magna',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: !widget.loading ? _selectPurpose : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.disabled)
                  ? null
                  : Theme.of(context).colorScheme.secondary,
            ),
            fixedSize: MaterialStateProperty.all(
              Size(
                ScreenSize.of(context).width - 40,
                50,
              ),
            ),
          ),
          child: const Text(
            'Select loan purpose',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  Future<void> _selectPurpose() async {
    final purpose = await _showPurposeDialog();
    if (purpose != null) {
      widget.onChanged(purpose);
    }
  }

  Future<String?> _showPurposeDialog() async {
    return showModalBottomSheet(
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
                  itemCount: purposeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      selected: purposeList[index] == widget.selectedPurpose,
                      title: Text(purposeList[index]),
                      onTap: () {
                        Navigator.pop(context, purposeList[index]);
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
  }
}
