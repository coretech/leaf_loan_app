import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/features/about/about.dart';
import 'package:loan_app/features/user_profile/presentation/widgets/widgets.dart';
import 'package:loan_app/features/user_profile/user_profile.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/user-profile';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider()
      ..getUser()
      ..addListener(
        () {
          if (_userProvider.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_userProvider.errorMessage!),
              ),
            );
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _userProvider,
      builder: (context, _) {
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AboutScreen.routeName);
                    },
                    icon: const Icon(Icons.info_outline),
                  )
                ],
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                centerTitle: true,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.onBackground,
                pinned: true,
                title: const Text('Leaf Profile'),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const NameWidget(),
                          const _ProvideDivider(),
                          const ContactInfo(),
                          const SizedBox(height: 20),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Edit on Leaf Wallet'),
                          ),
                          const _ProvideDivider(),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Text(
                              'Loan Stats',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              height: 150,
                            ),
                            items: const [
                              TotalLoanAmountCard(),
                              TotalNumberOfLoansCard(),
                              AverageLoanAmountCard(),
                              AverageLoanDurationCard(),
                            ],
                          ),
                          const _ProvideDivider(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.exit_to_app),
                            label: const Text('Log Out'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProvideDivider extends StatelessWidget {
  const _ProvideDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      endIndent: 80,
      height: 40,
      indent: 80,
    );
  }
}
