import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';

import 'package:loan_app/features/loan_history/loan_history.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanHistoryScreen extends StatefulWidget {
  const LoanHistoryScreen({
    Key? key,
    this.hasActiveLoan = true,
  }) : super(key: key);

  static const String routeName = '/loan-history';

  final bool hasActiveLoan;

  @override
  State<LoanHistoryScreen> createState() => _LoanHistoryScreenState();
}

class _LoanHistoryScreenState extends State<LoanHistoryScreen> {
  final LoanHistoryProvider _loanHistoryProvider =
      LoanHistoryIOC.loanHistoryProvider()..getLoans();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanHistoryProvider,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            title: Text('Loans History'.tr()),
          ),
          body: Consumer<LoanHistoryProvider>(
            builder: (context, loanHistoryProvider, _) {
              return _buildBody(loanHistoryProvider);
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(LoanHistoryProvider loanHistoryProvider) {
    final loading = loanHistoryProvider.loading;
    final loans = loanHistoryProvider.loans;
    if (loans.isNotEmpty || loading) {
      return LoansList(
        loans: loans,
        hasActiveLoan: widget.hasActiveLoan,
        loading: loading,
      );
    } else if (loanHistoryProvider.errorMessage != null) {
      return Center(
        child: CustomErrorWidget(
          message: loanHistoryProvider.errorMessage!,
          onRetry: () => loanHistoryProvider.getLoans(),
        ),
      );
    } else {
      return const NoLoansWidget();
    }
  }
}
