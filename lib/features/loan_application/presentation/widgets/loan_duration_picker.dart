import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loan_app/core/utils/utils.dart';

class LoanDurationPicker extends StatefulWidget {
  const LoanDurationPicker({Key? key}) : super(key: key);

  @override
  _LoanDurationPickerState createState() => _LoanDurationPickerState();
}

class _LoanDurationPickerState extends State<LoanDurationPicker> {
  // a widget that shows a date and the difference in days between the date and
  // today

  DateTime _selectedDate = DateTime.now().add(Duration(days: 3));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    DateFormat.yMMMMd().format(_selectedDate),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              _buildDayCount(context, _selectedDate),
            ],
          ),
        ),
        Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.calendar_today),
            label: const Text(
              'Select payment due date',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              _pickDate(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
              fixedSize: MaterialStateProperty.all(
                Size(
                  ScreenSize.of(context).width - 40,
                  50,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCount(BuildContext context, DateTime date) {
    final String dayCount = date.difference(DateTime.now()).inDays.toString();
    return Text("$dayCount days", style: Theme.of(context).textTheme.bodyText1);
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }
}
