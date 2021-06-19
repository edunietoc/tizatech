import 'package:intl/intl.dart';

String parseDate(String date, String time) {
  DateTime _date = DateTime.parse(date);
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (_date == today) {
    return time;
  } else if (_date == yesterday) {
    return 'Ayer';
  } else {
    return DateFormat.MMMd().format(_date);
  }
}
