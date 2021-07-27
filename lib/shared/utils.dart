import 'package:intl/intl.dart';
import 'package:tizatech/shared/constants.dart';

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

String dateTimeWithTimeZone() {
  DateTime date = DateTime.now();

  String timeZone = date.timeZoneOffset.toString().split('.')[0];
  String _date = date.toIso8601String().split('.')[0];
  String hh = timeZone.split(':')[0];

  if (int.parse(hh).abs() < 10) {
    List<String> charList = timeZone.split('')..insert(1, '0');
    charList = charList.sublist(0, charList.lastIndexOf(':'));

    timeZone = charList.join();
  }

  return _date + timeZone;
}

String dateOnly(DateTime date) {
  String stringDate = date.toIso8601String();
  return stringDate.split('T')[0];
}

String currentYear() => DateTime.now().year.toString();

String currentMonth() {
  int month = DateTime.now().month;
  print(month);
  print(monthConstants[month]);
  return monthConstants[month];
}
