import 'package:flutter/material.dart';

import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:provider/provider.dart';

class LoanDetailScreen extends StatefulWidget {
  const LoanDetailScreen({
    Key? key,
    required this.loan,
  }) : super(key: key);

  final LoanData loan;

  @override
  State<LoanDetailScreen> createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen> {
  late LoanDetailProvider _loanDetailProvider;

  @override
  void initState() {
    super.initState();
    _loanDetailProvider = LoanDetailProvider()
      ..setLoan(widget.loan)
      ..getPayments();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanDetailProvider,
      builder: (context, _) {
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              LoanDetailAppBar(
                loan: widget.loan,
              ),
              const SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    LoanDetailWidget(),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PaymentsHistoryColumnLabels(),
                pinned: true,
              ),
              const LoanPayments()
            ],
          ),
        );
      },
    );
  }
}
