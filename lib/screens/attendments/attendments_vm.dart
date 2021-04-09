import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tizatech/shared/colors.dart';

import '../../models/attendments.dart';
import '../../services/student.dart';

class AttendementsViewModel extends ChangeNotifier {
  String _error;
  String get error => _error;

  set error(String error) {
    _error = error;
    notifyListeners();
  }

  final StudentService _studentService = StudentService();

  List<charts.Series> _attendmentsMonthSeriesList;
  List<charts.Series> get attendmentsMonthSeriesList =>
      _attendmentsMonthSeriesList;
  set attendmentsMonthSeriesList(List<charts.Series> series) {
    _attendmentsMonthSeriesList = series;
    notifyListeners();
  }

  Future<List<charts.Series>> getMonthAttendments() async {
    print('running');
    try {
      List<Attendments> attendmentList =
          await _studentService.getAttendments(1247);

      attendmentList
          .sort((Attendments a1, Attendments a2) => a1.date.compareTo(a2.date));
      List<Week> weeks = getWeeksInAMonth(
          attendmentList[0].date.year, attendmentList[0].date.month);

      weeks.forEach((currentWeek) {
        currentWeek.dates.forEach((date) {
          attendmentList.forEach((attendment) {
            if (attendment.date == date && attendment.didAttend) {
              print('COMPARING: ${attendment.date} and $date');
              currentWeek.weekAttendments++;
            }
          });
        });
        print('Asistencias en esta semana ${currentWeek.weekAttendments}');
      });

      attendmentsMonthSeriesList = getAttendmentSeries(weeks);
      notifyListeners();
    } on Exception catch (e) {
      error = e.toString();
    }
  }

  List<charts.Series> getAttendmentSeries(List<Week> list) {
    List series = <charts.Series<Week, String>>[
      charts.Series(
        id: 'Asistencia',
        data: list,
        seriesColor: charts.Color.fromHex(code: '#42B0A6'),
        domainFn: (Week datum, index) => 'S${index + 1}',
        measureFn: (Week datum, index) => datum.weekAttendments,
      )
    ];
    return series;
  }

  List<Week> getWeeksInAMonth(int year, int month) {
    List<Week> weeks = <Week>[];

    int _currentWeek = 0;
    List<DateTime> acumulativeDates = [];
    for (int i = 1; i < 35; i++) {
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
        acumulativeDates = [];
        _currentWeek++;
        weeks.add(Week());
      }
    }

    return weeks;
  }
}

class Week {
  Week({this.dates, this.weekAttendments = 0});
  List<DateTime> dates;
  int weekAttendments;
}
