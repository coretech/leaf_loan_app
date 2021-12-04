import 'package:flutter/material.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

class LoanDescription extends StatelessWidget {
  const LoanDescription({
    Key? key,
    required this.loanType,
  }) : super(key: key);

  final LoanType loanType;

  @override
  Widget build(BuildContext context) {
    return Description(
      text: loanType.description,
      title: loanType.name,
    );
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
