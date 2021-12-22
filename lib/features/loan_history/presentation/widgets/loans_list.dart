import 'package:flutter/material.dart';

import 'package:loan_app/core/presentation/presentation.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';

class LoansList extends StatelessWidget {
  const LoansList({
    Key? key,
    required this.loans,
    required this.loading,
    required this.hasActiveLoan,
  }) : super(key: key);

  final List<LoanData> loans;
  final bool loading;
  final bool hasActiveLoan;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return _buildShimmer(context);
    }
    return ListView(
      padding: const EdgeInsets.all(5),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildActiveLoan(context),
        ...loans.map((loan) => _buildLoan(context, loan)),
      ],
    );
  }

  Widget _buildActiveLoan(BuildContext context) {
    final activeLoan = _getActiveLoan();
    if (activeLoan == null) {
      return const SizedBox.shrink();
    }
    return ActiveLoanCard(
      loan: activeLoan,
    );
  }

  Widget _buildLoan(BuildContext context, LoanData loan) {
    return LoanCard(
      loan: loan,
    );
  }

  LoanData? _getActiveLoan() {
    for (final loan in loans) {
      if (loan.status.toLowerCase() == 'approved') {
        return loan;
      }
    }
  }

  Widget _buildShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          if (hasActiveLoan)
            ShimmerBox(
              width: ScreenSize.of(context).width,
              height: 275,
            ),
          if (hasActiveLoan) const SizedBox(height: 15),
          ...List.filled(
            3,
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: ShimmerBox(
                width: ScreenSize.of(context).width,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
