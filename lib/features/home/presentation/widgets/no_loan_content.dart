import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class NoLoanContent extends StatelessWidget {
  const NoLoanContent({
    Key? key,
    required this.onApply,
  }) : super(key: key);
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    //a list of big cards with images and titles for the articles
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              const SizedBox(height: 20),
              Consumer<HomeProvider>(
                builder: (context, homeProvider, _) {
                  return Text(
                    '${'Welcome'.tr()}, ${homeProvider.firstName}!',
                    style: Theme.of(context).textTheme.headline5,
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Leaf provides you small loans that you can pay with any '
                        'currency available in your Leaf Wallet'
                    .tr(),
              ),
              const SizedBox(height: 20),
              Text(
                'You have no active loans at the moment'.tr(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const BigPersistentApplyButton(),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Recent from Leaf'.tr(),
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Divider(
                endIndent: 30,
                indent: 30,
              ),
            ],
          ),
        ),
        const SliverFillRemaining(
          child: ArticlesList(
            type: ArticleListType.nonScrollable,
          ),
        )
      ],
    );
  }
}
