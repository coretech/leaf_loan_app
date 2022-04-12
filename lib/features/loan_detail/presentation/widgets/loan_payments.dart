import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/widgets/widgets.dart';
import 'package:loan_app/features/loan_detail/loan_detail.dart';
import 'package:provider/provider.dart';

class LoanPayments extends StatelessWidget {
  const LoanPayments({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanDetailProvider>(
      builder: (context, loanDetailProvider, _) {
        if (loanDetailProvider.loading) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.all(10),
                child: PaymentDetailCard.shimmer(context),
              ),
              childCount: 5,
            ),
          );
        }
        if (loanDetailProvider.errorMessage != null) {
          return SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CustomErrorWidget(
                        message: loanDetailProvider.errorMessage!,
                        onRetry: loanDetailProvider.getPayments,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        if (loanDetailProvider.payments.isEmpty) {
          return const SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Center(
                  child: CustomErrorWidget(
                    message: "Looks like you haven't made any payments yet",
                  ),
                ),
              ],
            ),
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
                  currencyFiat: loanDetailProvider.loan!.currency.fiatCode,
                  payment: loanDetailProvider.payments[index],
                ),
              );
            },
            childCount: loanDetailProvider.payments.length,
          ),
        );
      },
    );
  }
}
