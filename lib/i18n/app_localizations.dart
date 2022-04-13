import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_app/core/core.dart';

class AppLocalizations implements L10n {
  AppLocalizations(this.locale);

  final Locale locale;

  late Map<String, String> _localizedStrings;

  static List<Locale> get supportedLocales => const [
        Locale(LocaleCodes.english, ''),
        Locale(LocaleCodes.kinyarwanda),
        Locale(LocaleCodes.swahili, ''),
        Locale(LocaleCodes.french, ''),
      ];

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load() async {
    final jsonString =
        await rootBundle.loadString('assets/l10n/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  @override
  String translate(String key, {Map<String, String>? values}) {
    var value = _localizedStrings[key];
    if (value == null) {
      _saveKey(key);
      value = key;
    }
    if (values != null) {
      values.forEach((key, _) {
        value = value!.replaceAll('{$key}', values[key]!);
      });
    }
    return value!;
  }

  Future<void> _saveKey(key) async {
    final database = FirebaseDatabase.instance;
    final ref =
        database.ref().child('missing_keys/${locale.languageCode}').push();
    await ref.set({'key': key});
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations
// object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of supported language codes here
    return AppLocalizations.supportedLocales
        .map((l) => l.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final localizations = AppLocalizations(locale);
    await localizations.load();
    IntegrationIOC.registerI18n(localizations);
    //This needs to be replaced at some point in time
    return const DefaultMaterialLocalizations();
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
