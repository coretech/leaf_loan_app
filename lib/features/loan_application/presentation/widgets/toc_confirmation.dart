import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';

class TOCConfirmation extends StatelessWidget {
  const TOCConfirmation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'By clicking on the'.tr(),
              style: Theme.of(context).textTheme.caption,
            ),
            TextSpan(
              text: ' ${'Submit Button'.tr()} ',
              style: Theme.of(context).textTheme.button,
            ),
            TextSpan(
              text: 'below, I hereby agree to and accept the following terms '
                      'and conditions governing my loan as stated in the'
                  .tr(),
              style: Theme.of(context).textTheme.caption,
            ),
            TextSpan(
              text: 'Terms and Conditions.'.tr(),
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
      ),
    );
  }
}
