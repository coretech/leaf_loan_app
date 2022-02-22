library country_util_test;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/utils/country_util.dart';

void main() {
  test(
    'Given a country name Ethiopia, '
    'When CountryUtil.getCode is called with the name, '
    'Then ET should be returned',
    () {
      final code = CountryUtil.getCode('Ethiopia');
      expect(code, 'ET');
    },
  );

  test(
    "Given a Locale Locale('fr'), "
    'When CountryUtil.getLanguageName is called, '
    'Then French must be returned',
    () {
      final languageName =
          CountryUtil.getLanguageName(const Locale(LocaleCodes.french));
      expect(languageName, 'French');
    },
  );

  test(
    "Given a Locale Locale('en'), "
    'When CountryUtil.getLanguageName is called, '
    'Then English must be returned',
    () {
      final languageName = CountryUtil.getLanguageName(
        const Locale(LocaleCodes.english),
      );
      expect(languageName, 'English');
    },
  );

  test(
    "Given a Locale Locale('sw'), "
    'When CountryUtil.getLanguageName is called, '
    'Then Swahili must be returned',
    () {
      final languageName =
          CountryUtil.getLanguageName(const Locale(LocaleCodes.swahili));
      expect(languageName, 'Swahili');
    },
  );

  test(
    "Given a Locale Locale('rw'), "
    'When CountryUtil.getLanguageName is called, '
    'Then Kinyarwanda must be returned',
    () {
      final languageName = CountryUtil.getLanguageName(
        const Locale(LocaleCodes.kinyarwanda),
      );
      expect(languageName, 'Kinyarwanda');
    },
  );
}
