import 'package:flutter/material.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/articles/articles.dart';
import 'package:loan_app/features/home/home.dart';
import 'package:loan_app/features/loan_history/loan_history.dart';

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
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Text(
                'Welcome, John! 👋🏾',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              const Text(
                'Leaf provides you small loans that you '
                'can pay with any currency that is available in your wallet',
              ),
              const SizedBox(height: 10),
              Text(
                'You have no active loans at the moment',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        SliverPersistentHeader(
          delegate: BigPersistentApplyButton(
            onApply: onApply,
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Recent from Leaf',
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return const ArticleCard();
            },
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              ActiveLoanAction(
                title: 'Articles',
                description: 'Read about how Leaf is helping its users achieve'
                    ' their goals with small loans',
                onTap: () {
                  Navigator.of(context).pushNamed(ArticlesScreen.routeName);
                },
              ),
              ActiveLoanAction(
                title: 'Loan History',
                description: 'See you loan history with them payment details',
                onTap: () {
                  Navigator.of(context).pushNamed(LoanHistoryScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
