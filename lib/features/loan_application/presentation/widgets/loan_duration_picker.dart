import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loan_app/core/core.dart';

import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanDurationPicker extends StatefulWidget {
  const LoanDurationPicker({
    Key? key,
    required this.durationInDays,
    required this.loading,
    required this.maxDurationInDays,
    required this.minDurationInDays,
    required this.onChanged,
  }) : super(key: key);
  final int durationInDays;
  final bool loading;
  final int? maxDurationInDays;
  final int? minDurationInDays;
  final ValueChanged<int> onChanged;

  @override
  _LoanDurationPickerState createState() => _LoanDurationPickerState();
}

class _LoanDurationPickerState extends State<LoanDurationPicker> {
  DateTime _selectedDate = DateTime.now().add(
    const Duration(days: 61),
  );

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
            'Choose the loan duration'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                    ' sed do eiusmod tempor incididunt ut labore et dolore '
                    'magna'
                .tr(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.5,
            horizontal: 8,
          ),
          child: _buildSelectedDate(),
        ),
        Center(
          child: ElevatedButton(
            onPressed: !widget.loading ? () => _pickDate(context) : null,
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
            child: Text(
              'Select payment due date'.tr(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCount(BuildContext context, DateTime date) {
    final dayCount = date.difference(DateTime.now()).inDays.toString();
    return Text(
      '$dayCount ${'days'.tr()}',
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget _buildSelectedDate() {
    if (widget.loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          ShimmerBox(
            width: 150,
            height: 20,
          ),
          ShimmerBox(
            width: 30,
            height: 20,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Text(
              DateFormat.yMMMMd().format(_selectedDate),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          _buildDayCount(context, _selectedDate),
        ],
      );
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().add(
        Duration(days: widget.minDurationInDays ?? 61),
      ),
      initialDate: _selectedDate,
      lastDate: DateTime.now().add(
        Duration(days: widget.maxDurationInDays ?? 90),
      ),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }
}
