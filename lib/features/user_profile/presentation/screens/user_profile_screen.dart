import 'package:flutter/material.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/presentation/presentation.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/settings/settings.dart';
import 'package:loan_app/features/user_profile/user_profile.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/user-profile';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProvider _userProvider;
  final _remoteConfig = IntegrationIOC.remoteConfig;
  late bool _shouldShowStats;

  @override
  void initState() {
    _shouldShowStats = _remoteConfig.getBool(RemoteConfigKeys.showLoanStats);
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
    return ChangeNotifierProvider.value(
      value: _userProvider,
      builder: (context, _) {
        return Scaffold(
          body: Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverAppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SettingsScreen.routeName);
                        },
                        icon: const Icon(Icons.settings_outlined),
                      )
                    ],
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    centerTitle: true,
                    elevation: 0,
                    foregroundColor: Theme.of(context).colorScheme.onBackground,
                    pinned: true,
                    title: Text('Leaf Profile'.tr()),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              if (userProvider.errorMessage != null)
                                Center(
                                  child: CustomErrorWidget(
                                    message: userProvider.errorMessage!,
                                    onRetry: userProvider.getUser,
                                  ),
                                ),
                              if (userProvider.errorMessage == null)
                                Column(
                                  children: [
                                    const NameWidget(),
                                    const _ProvideDivider(),
                                    const ContactInfo(),
                                    const SizedBox(height: 20),
                                    TextButton.icon(
                                      onPressed: () {
                                        UserProfileAnalytics
                                            .logEditProfileTapped(
                                          _userProvider.user?.username,
                                        );
                                        _launchApp();
                                      },
                                      icon: const Icon(Icons.edit_outlined),
                                      label: Text('Edit on Leaf Wallet'.tr()),
                                    ),
                                  ],
                                ),
                              const _ProvideDivider(),
                              if (_shouldShowStats)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Text(
                                    'Loan Stats'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              if (_shouldShowStats) const StatsCarousel(),
                              if (_shouldShowStats) const _ProvideDivider(),
                              TextButton.icon(
                                onPressed: () {
                                  UserProfileAnalytics.logLogOutTapped(
                                    _userProvider.user?.username,
                                  );
                                  AuthIOC.authHelper().logOut();
                                },
                                icon: const Icon(Icons.exit_to_app),
                                label: Text('Log Out'.tr()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _launchApp() async {
    await ExternalLinks.launchApp();
  }
}

class _ProvideDivider extends StatelessWidget {
  const _ProvideDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.secondary,
      endIndent: 80,
      height: 40,
      indent: 80,
    );
  }
}
