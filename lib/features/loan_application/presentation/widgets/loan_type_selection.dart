import 'package:flutter/material.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/features/loan_application/domain/value_objects/value_objects.dart';

//a widget to show three options laid out horizontally for choosing loan type 
// of which one can be taken. selected by the user. The options should be cards 
// with an image and a text under it. The text should be a body text.
// the image should take up most of the height of the card.

class LoanTypeSelection extends StatelessWidget {
  const LoanTypeSelection({
    Key? key,
    required this.onSelection,
    required this.selectedLoanType,
  }) : super(key: key);
  final ValueChanged<LoanType> onSelection;
  final LoanType selectedLoanType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Choose a loan type',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildLoanTypeCard(
              context,
              imagePath: 'assets/images/personal.png',
              loanType: LoanType.personal,
              title: 'Personal',
            ),
            _buildLoanTypeCard(
              context,
              imagePath: 'assets/images/business.png',
              loanType: LoanType.business,
              title: 'Business',
            ),
            _buildLoanTypeCard(
              context,
              imagePath: 'assets/images/asset.png',
              loanType: LoanType.asset,
              title: 'Asset',
            ),
          ],
        ),
        LoanDescription(
          loanType: selectedLoanType,
        )
      ],
    );
  }

  Widget _buildLoanTypeCard(
    BuildContext context, {
    required LoanType loanType,
    required String title,
    required String imagePath,
  }) {
    return Stack(
      children: [
        Card(
          elevation: 4,
          child: InkWell(
            onTap: () => onSelection(loanType),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    imagePath,
                    height: 64,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (selectedLoanType == loanType)
          Positioned(
            top: 10,
            right: 10,
            child: Center(
              child: Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
