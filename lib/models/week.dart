import 'attendments.dart';

class Week {
  Week({
    this.dates,
    this.weekAttendments = 0,
    this.weekUnattendments = 0,
    this.weekDelayments = 0,
  });
  List<DateTime> dates;
  int weekAttendments;
  int weekUnattendments;
  int weekDelayments;
}

List<Week> getWeeksInAMonth(int year, int month) {
  List<Week> weeks = <Week>[];

  int _currentWeek = 0;
  List<DateTime> acumulativeDates = <DateTime>[];
  for (int i = 1; i <= 32; i++) {
    DateTime date = DateTime(year, month, i);

    if (date.day != i) {
      weeks[_currentWeek].dates = acumulativeDates;
      break;
    }
    if (date.day == 1) {
      weeks.add(Week());
    }

    acumulativeDates.add(date);

    if (date.weekday == DateTime.sunday) {
      weeks[_currentWeek].dates = acumulativeDates;
      acumulativeDates = <DateTime>[];
      _currentWeek++;
      weeks.add(Week());
    }
  }

  return weeks;
}

List<Week> calculateMonthData(
    List<Week> weeks, List<Attendment> attendmentList) {
  weeks.forEach(
    (Week currentWeek) => currentWeek.dates.forEach(
      (DateTime date) => attendmentList.forEach(
        (Attendment attendment) {
          if (attendment.date == date && attendment.isDelayed) {
            currentWeek.weekDelayments++;
          }
          if (attendment.date == date && attendment.didAttend) {
            currentWeek.weekAttendments++;
          } else if (attendment.date == date && !attendment.didAttend) {
            currentWeek.weekUnattendments++;
          }
        },
      ),
    ),
  );
  return weeks;
}
