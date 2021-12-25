import 'package:flutter/material.dart';
import 'package:loan_app/features/user_profile/presentation/widgets/widgets.dart';
import 'package:loan_app/i18n/i18n.dart';

class TotalLoanAmountCard extends StatelessWidget {
  const TotalLoanAmountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Loan Amount Taken'.tr(),
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
              textAlign: TextAlign.right,
            ),
            const StatDivider(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '1,032,342.78',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextSpan(
                    text: ' RWF',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'This is the total amount you have borrowed through Leaf Loans.'
                    .tr(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 10,
                    ),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
  }
}
