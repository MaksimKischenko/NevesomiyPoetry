import 'package:intl/intl.dart';


extension DateHelperDateTime on DateTime {

  String toStringFormatted() => DateFormat('yyyy-MM-dd').format(this);

  String toStringFormattedGetOperationHistory() => DateFormat('dd.MM.yyyy HH:mm').format(this);

}

extension DateTimeExtension on DateTime? {
  String parseToString(String dateFormat) {
    if (this == null) return '';
    return DateFormat(dateFormat).format(this ?? DateTime.now());
  }
   String toStringFormatted() => DateFormat('dd.MM.yyyy').format(this ?? DateTime.now());
}

