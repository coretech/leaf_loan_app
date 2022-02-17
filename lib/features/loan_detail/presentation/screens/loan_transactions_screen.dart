import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';

import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanTransactionsScreen extends StatefulWidget {
  const LoanTransactionsScreen({
    Key? key,
    required this.loan,
  }) : super(key: key);
  final LoanData loan;
  static const routeName = '/loan-transactions';

  @override
  State<LoanTransactionsScreen> createState() => _LoanTransactionsScreenState();
}

class _LoanTransactionsScreenState extends State<LoanTransactionsScreen> {
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
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            title: Text('Loan Transaction History'.tr()),
          ),
          body: RefreshIndicator(
            onRefresh: () => _loanDetailProvider.getPayments(),
            child: const CustomScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                LoanPayments(),
              ],
            ),
          ),
        );
      },
    );
  }
}
