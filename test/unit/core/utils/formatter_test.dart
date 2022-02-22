library formatter_test;

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/core.dart';

void main() {
  test(
    '2022-01-05T10:48:21.653Z should be formatted as January 5, 2022 '
    'if formatted with Format.formatDate',
    () {
      final formattedDate =
          Formatter.formatDate(DateTime.parse('2022-01-05T10:48:21.653Z'));
      expect(formattedDate, 'January 5, 2022');
    },
  );

  test(
    '2022-01-05T10:48:21.653Z should be formatted as 5/1/22 '
    'if formatted with Format.formatDateMini',
    () {
      final formattedDate =
          Formatter.formatDateMini(DateTime.parse('2022-01-05T10:48:21.653Z'));
      expect(formattedDate, '5/1/22');
    },
  );

  test(
    '2022-01-05T10:48:21.653Z should be formatted as 5/1/22 '
    'if formatted with Format.formatDateWithTime',
    () {
      final formattedDate =
          Formatter.formatDateMini(DateTime.parse('2022-01-05T10:48:21.653Z'));
      expect(formattedDate, '5/1/22');
    },
  );

  test(
    '2022-01-05T10:48:21.653Z should be formatted as January 5, 2022 10:48 AM '
    'if formatted with Format.formatDateWithTime',
    () {
      final formattedDate = Formatter.formatDateWithTime(
        DateTime.parse('2022-01-05T10:48:21.653Z'),
        toLocal: false,
      );
      expect(formattedDate, 'January 5, 2022 10:48 AM');
    },
  );

  test(
    '2022-01-05T10:48:21.653Z should be formatted as January 5, 2022 10:48 AM '
    'if formatted with Format.formatTime',
    () {
      final formattedDate = Formatter.formatTime(
        DateTime.parse('2022-01-05T10:48:21.653Z'),
        toLocal: false,
      );
      expect(formattedDate, '10:48 AM');
    },
  );

  test(
    '100000.00 should be formatted as 100,000.00 '
    'if formatted with Format.formatMoney',
    () {
      final formattedDate =
          // ignore: prefer_int_literals
          Formatter.formatMoney(100000.00);
      expect(formattedDate, '100,000.00');
    },
  );

  test(
    '1783 should be formatted as 1,783 '
    'if formatted with Format.formatMoney',
    () {
      final formattedDate = Formatter.formatMoney(1783);
      expect(formattedDate, '1,783.00');
    },
  );
}
