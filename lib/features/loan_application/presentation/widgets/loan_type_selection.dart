import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/i18n/i18n.dart';

class LoanTypeSelection extends StatelessWidget {
  const LoanTypeSelection({
    Key? key,
    required this.loanLevel,
    required this.loanTypes,
    required this.onSelection,
    required this.selectedIndex,
    this.shouldShowTitle = true,
  }) : super(key: key);
  final LoanLevel loanLevel;
  final List<LoanType> loanTypes;
  final ValueChanged<int> onSelection;
  final int selectedIndex;
  final bool shouldShowTitle;

  static Widget shimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ShimmerBox(
          height: 30,
          padding: EdgeInsets.only(
            top: 5,
            bottom: 10,
            left: 10,
          ),
          width: 280,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.filled(
              3,
              const ShimmerBox(
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 100,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (shouldShowTitle)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Choose a loan type'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildLoanTypeCards(),
          ),
        ),
        LoanDescription(
          loanType: loanTypes[selectedIndex],
        ),
      ],
    );
  }

  List<Widget> _buildLoanTypeCards() {
    final loanTypeCards = <Widget>[];
    for (var i = 0; i < loanTypes.length; i++) {
      final loanType = loanTypes[i];
      loanTypeCards.add(
        Container(
          height: 175,
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: 150,
          child: LoanTypeCard(
            index: i,
            loanType: loanType,
            onSelection: onSelection,
            selectedLoanType: loanTypes[selectedIndex],
            userLoanLevel: loanLevel,
          ),
        ),
      );
    }
    return loanTypeCards;
  }
}
