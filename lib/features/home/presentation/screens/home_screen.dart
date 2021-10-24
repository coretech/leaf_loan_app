import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/features/loan_payment/loan_payment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.hasLoan,
    required this.onApply,
  }) : super(key: key);
  final bool hasLoan;
  final VoidCallback onApply;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: Theme.of(context).shadowColor.withOpacity(0.75),
                offset: const Offset(1, 3),
                spreadRadius: 0.5,
              ),
            ],
            color: Theme.of(context).primaryColor,
          ),
          height: ScreenSize.of(context).height * 0.55,
          width: ScreenSize.of(context).width,
          child: _getDashboard(),
        ),
        const Spacer(
          flex: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ApplyButton.withIcon(
              context: context,
              label: 'Apply',
              onTap: () {
                print('apply on home pressed');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoanApplicationScreen(
                        hasLoan: widget.hasLoan,
                      );
                    },
                  ),
                );
              },
            ),
            PayButton.withIcon(
              context: context,
              label: 'Pay',
              onTap: () {
                print('pay on home pressed');
              },
            )
          ],
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }

  Widget _getDashboard() {
    if (!widget.hasLoan) {
      return NoActiveLoanDashboard(
        onApplyPressed: widget.onApply,
      );
    } else {
      return Column(
        children: [
          const Text("Loan amount: \$50"),
          const Text("Interest: \$5"),
          const Text("Total due: \$55"),
          const Text("Amount paid: \$10"),
          const Text("Amount remaining: \$45"),
          const Text("Due date: 3/15/21"),
          const Text("6 days remaining"),
          ElevatedButton(
            onPressed: widget.onApply,
            child: const Text('toggle back'),
          ),
        ],
      );
    }
  }
}
