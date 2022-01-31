import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/about/about.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

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
                title: const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: _getLanguageWidget(context, l10nProvider),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(AboutScreen.routeName);
                },
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const FormTypeTile(),
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

class FormTypeTile extends StatefulWidget {
  const FormTypeTile({Key? key}) : super(key: key);

  @override
  _FormTypeTileState createState() => _FormTypeTileState();
}

class _FormTypeTileState extends State<FormTypeTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final current = (await IntegrationIOC.localStorage()
                .getString(RemoteConfigKeys.formContentType)) ??
            'A';
        final next = _getNextType(
          current,
        );
        await IntegrationIOC.localStorage().setString(
          RemoteConfigKeys.formContentType,
          next,
        );

        await RemoteConfig.instance.setDefaults({
          RemoteConfigKeys.formContentType: next,
          RemoteConfigKeys.showLoanStats: true,
        });

        setState(() {});
      },
      title: const Text(
        'Form Content Type',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: FutureBuilder<String?>(
        future: IntegrationIOC.localStorage().getString(
          RemoteConfigKeys.formContentType,
        ),
        builder: (context, snapshot) {
          return Text(
            snapshot.data ?? '-',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
    );
  }

  String _getNextType(String type) {
    switch (type) {
      case 'A':
        return 'B';
      case 'B':
        return 'C';
      default:
        return 'A';
    }
  }
}
