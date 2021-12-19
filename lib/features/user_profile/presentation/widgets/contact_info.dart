import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/user_profile/user_profile.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Text(
                'Contact Info'.tr(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Address'.tr(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(height: 5),
                      if (userProvider.loading)
                        const ShimmerBox(width: 100, height: 20)
                      else
                        Text(
                          userProvider.address,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Phone Number'.tr(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(height: 5),
                      if (userProvider.loading)
                        const ShimmerBox(width: 100, height: 20)
                      else
                        Text(
                          userProvider.phoneNumber,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (userProvider.user?.email != null)
              Column(
                children: [
                  Text(
                    'Email'.tr(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 5),
                  if (userProvider.loading)
                    const ShimmerBox(width: 100, height: 20)
                  else
                    Text(
                      userProvider.user!.email!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}
