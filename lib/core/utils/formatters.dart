import 'package:intl/intl.dart';

class Formatters {
  static final NumberFormat _currencyFormatter = NumberFormat('#,##0', 'en_US');

  /// Formats numbers to currency style, e.g. 2,500,000 ج.م
  static String formatEGP(num amount) {
    return '${_currencyFormatter.format(amount)} ج.م';
  }

  /// Formats area to m², e.g. 185 م²
  static String formatArea(num area) {
    return '${_currencyFormatter.format(area)} م²';
  }

  /// Formats number with commas
  static String formatNumber(num number) {
    return _currencyFormatter.format(number);
  }
}
