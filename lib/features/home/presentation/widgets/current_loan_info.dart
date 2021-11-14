import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';

class CurrentLoanInfo extends StatelessWidget {
  const CurrentLoanInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoanDetailScreen(
              dueDate: DateTime.now(),
              paidAmount: 234325,
              status: LoanStatus.due,
              totalAmount: 10234324,
            ),
          ),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Stack(
          children: [
            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.black.withOpacity(0.25),
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  Text(
                    'Pay before',
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'January 15, 2022',
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Remaining Amount',
                    style: TextStyle(
                      color: _getTextColor(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'KSH ',
                          style: TextStyle(
                            color: _getTextColor(context),
                          ),
                        ),
                        TextSpan(
                          text: '12,960',
                          style: TextStyle(
                            color: _getTextColor(context),
                            fontSize: 31,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.info,
                  color: _getTextColor(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }
}
