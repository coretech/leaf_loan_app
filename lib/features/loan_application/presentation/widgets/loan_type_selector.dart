import 'package:flutter/material.dart';

class LoanTypeSelector extends StatefulWidget {
  const LoanTypeSelector({
    Key? key,
  }) : super(key: key);

  @override
  State<LoanTypeSelector> createState() => _LoanTypeSelectorState();
}

class _LoanTypeSelectorState extends State<LoanTypeSelector> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.spaceEvenly,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Icon(
                  Icons.apartment,
                  size: 50,
                ),
                Text(
                  "Apartment Loan",
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Icon(
                  Icons.apartment,
                  size: 50,
                ),
                Text(
                  "Apartment Loan",
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Icon(
                  Icons.apartment,
                  size: 50,
                ),
                Text(
                  "Apartment Loan",
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
