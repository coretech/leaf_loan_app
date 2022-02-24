import 'package:flutter/material.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({
    Key? key,
    required this.location,
    this.onChanged,
  }) : super(key: key);
  final String location;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final supportedLocales = AppLocalizations.supportedLocales;
    return Consumer<L10nProvider>(
      builder: (context, l10nProvider, _) {
        return SizedBox(
          child: PopupMenuButton(
            elevation: 0,
            itemBuilder: (context) {
              final items = supportedLocales
                  .map(
                    (locale) => PopupMenuItem(
                      value: locale.languageCode,
                      child: Text(CountryUtil.getLanguageName(locale)),
                    ),
                  )
                  .toList();
              return items;
            },
            onSelected: (locale) {
              if (locale != null) {
                l10nProvider.changeLocale(Locale(locale as String));
                CoreAnalytics.logLanguageChanged(locale, location);
                onChanged?.call();
              }
            },
            initialValue: l10nProvider.locale.languageCode,
            child: Row(
              children: [
                Text(
                  CountryUtil.getLanguageName(l10nProvider.locale),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.language,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
