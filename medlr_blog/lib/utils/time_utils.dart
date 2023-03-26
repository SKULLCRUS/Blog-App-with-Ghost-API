import 'package:intl/intl.dart';

String prettyTimeStamp(DateTime dateTime) {
  final monthName = DateFormat('LLL').format(dateTime);
  final date = DateFormat('d').format(dateTime);
  return '$monthName, $date';
}
