import 'package:flutter/material.dart';

import 'package:loan_app/features/features.dart';

class LoanDescription extends StatelessWidget {
  const LoanDescription({
    Key? key,
    required this.loanType,
  }) : super(key: key);

  final LoanType loanType;

  @override
  Widget build(BuildContext context) {
    switch (loanType) {
      case LoanType.personal:
        return const Description(
          text: 'Personal loans are loans that are used to pay for'
              ' goods and services that you need. They are usually '
              'short-term and are usually repaid within a few months.',
          title: 'Personal',
        );
      case LoanType.business:
        return const Description(
          text: 'Business loans are loans that are used to pay for'
              ' goods and services that you need. They are usually '
              'short-term and are usually repaid within a few months.',
          title: 'Business',
        );
      case LoanType.asset:
        return const Description(
          text: 'Asset loans are loans that are used to pay for'
              ' goods and services that you need. They are usually '
              'short-term and are usually repaid within a few months.',
          title: 'Asset',
        );
    }
  }
}

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.text,
    required this.title,
  }) : super(key: key);
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
