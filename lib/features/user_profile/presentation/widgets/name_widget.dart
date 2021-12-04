import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/user_profile/user_profile.dart';
import 'package:provider/provider.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.loading) {
          return const ShimmerBox(width: 140, height: 40);
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userProvider.fullName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  if (userProvider.isVerified) const SizedBox(width: 10),
                  if (userProvider.isVerified)
                    Icon(
                      Icons.verified_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    )
                ],
              ),
            ),
            Text(
              userProvider.usernamePresentation,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        );
      },
    );
  }
}
