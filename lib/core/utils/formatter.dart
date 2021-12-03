import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat.yMMMMd(locale.languageCode);
    return dateFormat.format(date);
  }

  static String formatDateMini(DateTime date) {
    final dateFormat = DateFormat('d/M/yy');
    return dateFormat.format(date);
  }

  static String formatMoney(double amount) {
    final currencyFormatter = NumberFormat('#,##0', 'en_US');
    return currencyFormatter.format(amount);
  }
}
