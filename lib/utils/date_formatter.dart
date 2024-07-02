import 'package:intl/intl.dart';

class DateFormatter {
  static DateFormat dateFormat = DateFormat('dd MMM yyyy');
  static DateFormat invoiceDateFormat = DateFormat('dd/MM/yyyy');
  static DateFormat reportDateFormat = DateFormat('dd-MM-yyyy');
  static DateFormat dateFormatTime = DateFormat('jm');
  static DateFormat dateFormatter = DateFormat('dd-MM-yyyy h:mm a');
}

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
