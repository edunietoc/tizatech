import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../models/attendments.dart';
import '../../models/week.dart';
import '../../services/student.dart';

class AttendementsViewModel extends ChangeNotifier {
  String _error;
  int totalAttendments;
  int totalUnattendments;

  String get error => _error;

  set error(String error) {
    _error = error;
    notifyListeners();
  }

  final StudentService _studentService = StudentService();

  List<charts.Series<Week, String>> _attendmentsMonthSeriesList;
  List<charts.Series<Week, String>> get attendmentsMonthSeriesList =>
      _attendmentsMonthSeriesList;
  set attendmentsMonthSeriesList(List<charts.Series<Week, String>> series) {
    _attendmentsMonthSeriesList = series;
    notifyListeners();
  }

  Future<void> getMonthAttendments() async {
    try {
      List<Attendment> attendmentList =
          await _studentService.getAttendments(1247);

      attendmentList
          .sort((Attendment a1, Attendment a2) => a1.date.compareTo(a2.date));
      List<Week> weeks = getWeeksInAMonth(
          attendmentList[0].date.year, attendmentList[0].date.month);

      Map<String, Object> data = calculateMonthData(weeks, attendmentList);
      weeks = data['weeks'];
      MonthData monthData = data['monthData'];
      totalAttendments = monthData.totalAttendments;
      totalUnattendments = monthData.totalUnattendments;

      attendmentsMonthSeriesList = getAttendmentSeries(weeks);

      notifyListeners();
    } on Exception catch (e) {
      error = e.toString();
    }
  }

  List<charts.Series<Week, String>> getAttendmentSeries(List<Week> list) {
    List<charts.Series<Week, String>> series = <charts.Series<Week, String>>[
      charts.Series<Week, String>(
        id: 'Inasistencia',
        data: list,
        seriesColor: charts.Color.fromHex(code: '#F06C79'),
        domainFn: (Week datum, int index) => 'S${index + 1}',
        measureFn: (Week datum, _) => datum.weekUnattendments,
      ),
      charts.Series<Week, String>(
        id: 'Asistencia',
        data: list,
        seriesColor: charts.Color.fromHex(code: '#42B0A6'),
        domainFn: (Week datum, int index) => 'S${index + 1}',
        measureFn: (Week datum, _) => datum.weekAttendments,
      ),
    ];
    return series;
  }
}
