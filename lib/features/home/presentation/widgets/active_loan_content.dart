import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/articles/articles.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';

class ActiveLoanContent extends StatefulWidget {
  const ActiveLoanContent({
    Key? key,
    this.onPay,
  }) : super(key: key);
  final VoidCallback? onPay;

  @override
  State<ActiveLoanContent> createState() => _ActiveLoanContentState();
}

class _ActiveLoanContentState extends State<ActiveLoanContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const CurrentLoanInfo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LoanActionButtons(
                      hasActiveLoan: true,
                      onPay: widget.onPay,
                    ),
                  ),
                  ActiveLoanAction(
                    title: 'Transactions',
                    description:
                        'Take a look at the transaction history for your '
                        'current loan',
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
                  ),
                  ActiveLoanAction(
                    title: 'Articles',
                    description:
                        'Read about how Leaf is helping its users acheive'
                        ' their goals with small loans',
                    onTap: () {
                      Navigator.of(context).pushNamed(ArticlesScreen.routeName);
                    },
                  ),
                  ActiveLoanAction(
                    title: 'Loan History',
                    description:
                        'See you loan history with them payment details',
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(LoanHistoryScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
