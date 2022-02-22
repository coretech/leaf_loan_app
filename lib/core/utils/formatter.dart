import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime date, {bool toLocal = true}) {
    final dateFormat = DateFormat.yMMMMd();
    if (toLocal) {
      return dateFormat.format(date.toLocal());
    }
    return dateFormat.format(date);
  }

  static String formatDateMini(DateTime date, {bool toLocal = true}) {
    final dateFormat = DateFormat('d/M/yy');
    if (toLocal) {
      return dateFormat.format(date.toLocal());
    }
    return dateFormat.format(date);
  }

  static String formatMoney(double amount) {
    final currencyFormatter = NumberFormat('#,##0.00', 'en_US');
    return currencyFormatter.format(amount);
  }

  static String formatDateWithTime(DateTime date, {bool toLocal = true}) {
    final dateFormat = DateFormat.yMMMMd().add_jm();
    if (toLocal) {
      return dateFormat.format(date.toLocal());
    }
    return dateFormat.format(date);
  }

  static String formatTime(DateTime date, {bool toLocal = true}) {
    final dateFormat = DateFormat.jm();
    if (toLocal) {
      return dateFormat.format(date.toLocal());
    }
    return dateFormat.format(date);
  }
}
