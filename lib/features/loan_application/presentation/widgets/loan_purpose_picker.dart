import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanPurposePicker extends StatefulWidget {
  const LoanPurposePicker({
    Key? key,
    required this.loading,
    required this.onChanged,
    required this.purposeList,
    required this.selectedPurpose,
    this.shouldShowTitle = true,
  }) : super(key: key);
  final bool loading;
  final ValueChanged<String> onChanged;
  final List<String> purposeList;
  final String? selectedPurpose;
  final bool shouldShowTitle;

  @override
  _LoanPurposePickerState createState() => _LoanPurposePickerState();
}

class _LoanPurposePickerState extends State<LoanPurposePicker> {
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
              'Choose the loan purpose'.tr(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Please choose the closest reason for requesting this loan. '
                    "This will not impact your loan's approval and is "
                    'strictly for informational purposes. If you do '
                    "not see an appropriate category, choose 'Other' "
                    'and input a reason.'
                .tr(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selected Purpose'.tr(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.selectedPurpose ?? 'None'.tr(),
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
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
          child: Text(
            'Select loan purpose'.tr(),
            style: const TextStyle(fontSize: 18),
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
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 25,
                  child: Text(
                    'Loan Purpose'.tr(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    endIndent: 30,
                    indent: 30,
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      ...widget.purposeList.map((purpose) {
                        return ListTile(
                          selected: purpose == widget.selectedPurpose,
                          title: Text(purpose),
                          onTap: () {
                            Navigator.pop(context, purpose);
                          },
                        );
                      }).toList(),
                      _buildOtherField(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtherField() {
    final purpose = widget.purposeList.contains(widget.selectedPurpose)
        ? ''
        : widget.selectedPurpose;
    return ListTile(
      title: TextFormField(
        initialValue: purpose,
        decoration: InputDecoration(
          labelText: 'Other'.tr(),
          suffixIcon: TextButton(
            onPressed: () {
              if (widget.selectedPurpose?.isNotEmpty ?? false) {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Save'.tr(),
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
