import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/user_profile/presentation/widgets/widgets.dart';
import 'package:loan_app/i18n/i18n.dart';

class AverageLoanAmountCard extends StatelessWidget {
  const AverageLoanAmountCard({Key? key}) : super(key: key);

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
              'Average Loan Amount'.tr(),
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
                    text: Formatter.formatMoney(44884.46),
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
                'This is the total amount you have borrowed divided by the '
                        'number of loans you have taken.'
                    .tr(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontSize: 10,
                    ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
