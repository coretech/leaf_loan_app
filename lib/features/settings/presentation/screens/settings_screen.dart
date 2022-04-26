import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/about/about.dart';
import 'package:loan_app/features/contact_us/presentation/screens/screens.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text('Settings'.tr()),
      ),
      body: Consumer<L10nProvider>(
        builder: (context, l10nProvider, _) {
          return ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              ListTile(
                onTap: () {
                  _showChangeLanguagePopup(context, l10nProvider);
                },
                title: Text(
                  'Language'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: _getLanguageWidget(context, l10nProvider),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(ContactUsScreen.routeName);
                },
                title: Text(
                  'Contact Us'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.contact_support_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              ListTile(
                onTap: () {
                  Share.share(
                    'Hey there! Download Leaf Loans! http://onelink.to/leafloans'
                        .tr(),
                  );
                },
                title: Text(
                  'Share App'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.share_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(AboutScreen.routeName);
                },
                title: Text(
                  'About'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getLanguageWidget(
    BuildContext context,
    L10nProvider l10nProvider,
  ) {
    return Text(
      CountryUtil.getLanguageName(l10nProvider.locale),
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }

  void _showChangeLanguagePopup(
    BuildContext context,
    L10nProvider l10nProvider,
  ) {
    final supportedLocales = AppLocalizations.supportedLocales;
    log(l10nProvider.locale.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Language'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                for (final locale in supportedLocales)
                  ListTile(
                    onTap: () {
                      CoreAnalytics.logLanguageChanged(
                        locale.languageCode,
                        'settings',
                      );
                      l10nProvider.changeLocale(locale);
                      Navigator.of(context).pop();
                    },
                    selectedTileColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.15),
                    selected:
                        l10nProvider.locale.languageCode == locale.languageCode,
                    title: Text(CountryUtil.getLanguageName(locale)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
