import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/widgets/widgets.dart';

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
    this.shouldShowTitle = true,
  }) : super(key: key);
  final int durationInDays;
  final bool loading;
  final int? maxDurationInDays;
  final int? minDurationInDays;
  final ValueChanged<int> onChanged;
  final bool shouldShowTitle;

  @override
  _LoanDurationPickerState createState() => _LoanDurationPickerState();
}

class _LoanDurationPickerState extends State<LoanDurationPicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = DateTime.now().add(
      Duration(days: widget.durationInDays),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.shouldShowTitle)
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
            'Please choose a date within the window for paying back this '
                    "loan in full. Leaf's shortest minimum duration is 60 "
                    'days, though you may pay back your loan any time after '
                    'you receive it. The loan will automatically close once '
                    'fully paid.'
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
              'Select final payment due date'.tr(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCount(BuildContext context, DateTime date) {
    final dayCount = date.difference(DateTime.now()).inDays + 1;
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
              Formatter.formatDate(_selectedDate),
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
        Duration(days: widget.minDurationInDays ?? 60),
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
      widget.onChanged(date.difference(DateTime.now()).inDays + 1);
    }
  }
}
