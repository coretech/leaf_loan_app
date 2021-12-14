import 'package:flutter/material.dart';
import 'package:loan_app/features/user_profile/presentation/widgets/widgets.dart';
import 'package:loan_app/i18n/i18n.dart';

class AverageLoanDurationCard extends StatelessWidget {
  const AverageLoanDurationCard({Key? key}) : super(key: key);

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
              'Average Loan Duration'.tr(),
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
                    text: '97 ',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextSpan(
                    text: 'days'.tr(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'The average number of days it took you to pay back a loan.'
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
