import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime date) {
    final dateFormat = DateFormat.yMMMMd();
    return dateFormat.format(date);
  }

  static String formatDateMini(DateTime date) {
    final dateFormat = DateFormat('d/M/yy');
    return dateFormat.format(date);
  }

  static String formatMoney(double amount) {
    final currencyFormatter = NumberFormat('#,##0.00', 'en_US');
    return currencyFormatter.format(amount);
  }

  static String formatDateWithTime(DateTime date) {
    final dateFormat = DateFormat.yMMMMd().add_jm();
    return dateFormat.format(date);
  }
}
