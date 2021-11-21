import 'package:flutter/material.dart';

import 'package:loan_app/features/home/home.dart';

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
            child: SizedBox(
              height: constraint.maxHeight,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Recent Transactions',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const Expanded(
                    child: RecentTransactions(),
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
