import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';
import 'package:provider/provider.dart';

class LoanTypeSelection extends StatelessWidget {
  const LoanTypeSelection({
    Key? key,
    required this.onSelection,
  }) : super(key: key);
  final ValueChanged<int> onSelection;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanApplicationProvider>(
      builder: (context, loanApplicationProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Choose a loan type',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildLoanTypeCards(loanApplicationProvider),
            ),
            if (loanApplicationProvider.canShowTypes)
              LoanDescription(
                loanType: loanApplicationProvider.selectedLoanType!,
              )
            else
              const ShimmerBox(
                height: 30,
                padding: EdgeInsets.only(top: 5, bottom: 10, left: 10),
                width: 280,
              ),
          ],
        );
      },
    );
  }

  List<Widget> _buildLoanTypeCards(
    LoanApplicationProvider loanApplicationProvider,
  ) {
    if (loanApplicationProvider.canShowTypes) {
      final loanTypeCards = <Widget>[];
      for (var i = 0; i < loanApplicationProvider.loanTypes.length; i++) {
        final loanType = loanApplicationProvider.loanTypes[i];
        loanTypeCards.add(
          Container(
            height: 175,
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: 150,
            child: LoanTypeCard(
              onSelection: onSelection,
              selectedLoanType: loanApplicationProvider.selectedLoanType!,
              loanType: loanType,
              index: i,
            ),
          ),
        );
      }
      return loanTypeCards;
    }

    return List.filled(
      3,
      const ShimmerBox(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 100,
      ),
    );
  }
}
