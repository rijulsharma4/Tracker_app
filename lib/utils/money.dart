import 'package:intl/intl.dart';

String formatMoney(double amount, String currency) {
  final f = NumberFormat.currency(name: currency, decimalDigits: 2);
  return f.format(amount);
}