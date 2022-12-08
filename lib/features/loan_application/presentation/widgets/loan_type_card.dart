import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:loan_app/core/domain/domain.dart';

class LoanTypeCard extends StatelessWidget {
  const LoanTypeCard({
    Key? key,
    required this.index,
    required this.onSelection,
    required this.selectedLoanType,
    required this.loanType,
    required this.userLoanLevel,
  }) : super(key: key);

  final int index;
  final ValueChanged<int> onSelection;
  final LoanType selectedLoanType;
  final LoanType loanType;
  final LoanLevel userLoanLevel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: selectedLoanType == loanType
              ? Theme.of(context).primaryColorLight
              : null,
          elevation: 4,
          child: SizedBox(
            height: 145,
            width: 145,
            child: InkWell(
              onTap: _isAllowedLevel(loanType, userLoanLevel)
                  ? () => onSelection(index)
                  : () => _showErrorSnackbar(context),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: loanType.image,
                      height: 64,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loanType.name,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (selectedLoanType == loanType)
          Positioned(
            top: 10,
            right: 20,
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

  bool _isAllowedLevel(LoanType loanType, LoanLevel userLoanLevel) {
    final userLoanLevelNumber =
        double.tryParse(userLoanLevel.name.split(' ')[1]);
    final loanTypeLevelNumber =
        double.tryParse(loanType.loanLevel.name.split(' ')[1]);
    if (userLoanLevelNumber == null || loanTypeLevelNumber == null) {
      return false;
    }

    return userLoanLevelNumber >= loanTypeLevelNumber;
  }

  void _showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'You are not eligible for this loan type. '
          'Please select a lower loan type.',
          maxLines: 5,
        ),
      ),
    );
  }
}
