import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:provider/provider.dart';

class LoanPayments extends StatefulWidget {
  const LoanPayments({
    Key? key,
    required this.loan,
  }) : super(key: key);
  final LoanData loan;

  @override
  State<LoanPayments> createState() => _LoanPaymentsState();
}

class _LoanPaymentsState extends State<LoanPayments> {
  late LoanDetailProvider _loanDetailProvider;

  @override
  void initState() {
    super.initState();
    _loanDetailProvider = LoanDetailProvider()..getPayments(widget.loan.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanDetailProvider,
      builder: (context, _) {
        return Consumer<LoanDetailProvider>(
          builder: (context, loanDetailProvider, _) {
            if (loanDetailProvider.loading) {
              return const SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ]),
              );
            }
            if (loanDetailProvider.errorMessage != null) {
              return SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Center(
                    child: Text(loanDetailProvider.errorMessage!),
                  ),
                ]),
              );
            }
            if (loanDetailProvider.payments.isEmpty) {
              return const SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Center(
                    child: Text('No payments found'),
                  ),
                ]),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.5,
                      horizontal: 15,
                    ),
                    child: PaymentDetailCard(
                      currencyFiat: widget.loan.currencyId.fiatCode,
                      payment: loanDetailProvider.payments[index],
                    ),
                  );
                },
                childCount: loanDetailProvider.payments.length,
              ),
            );
          },
        );
      },
    );
  }
}
