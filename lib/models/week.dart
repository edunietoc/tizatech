import 'attendments.dart';

class Week {
  Week({
    this.dates,
    this.weekAttendments = 0,
    this.weekUnattendments = 0,
  });
  List<DateTime> dates;
  int weekAttendments;
  int weekUnattendments;
  int weekDelayments;
}

class MonthData {
  MonthData({
    this.totalAttendments = 0,
    this.totalUnattendments = 0,
    this.totalDelayments = 0,
  });
  int totalAttendments;
  int totalUnattendments;
  int totalDelayments;
}

List<Week> getWeeksInAMonth(int year, int month) {
  List<Week> weeks = <Week>[];

  int _currentWeek = 0;
  List<DateTime> acumulativeDates = <DateTime>[];
  for (int i = 1; i < 32; i++) {
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

Map<String, Object> calculateMonthData(
    List<Week> weeks, List<Attendment> attendmentList) {
  MonthData monthData = MonthData();
  weeks.forEach(
    (Week currentWeek) => currentWeek.dates.forEach(
      (DateTime date) => attendmentList.forEach(
        (Attendment attendment) {
          if (attendment.date == date && attendment.didAttend) {
            currentWeek.weekAttendments++;
            monthData.totalAttendments++;
          } else if (attendment.date == date && !attendment.didAttend) {
            currentWeek.weekUnattendments++;
            monthData.totalUnattendments++;
          } else if (attendment.date == date && attendment.isDelayed) {
            monthData.totalDelayments++;
          }
        },
      ),
    ),
  );
  return <String, Object>{
    'monthData': monthData,
    'weeks': weeks,
  };
}
