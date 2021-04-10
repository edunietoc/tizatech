import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../models/attendments.dart';
import '../../models/week.dart';
import '../../services/student.dart';

class DelaymentsViewModel extends ChangeNotifier {
  String _error;
  int totalDelayments;

  String get error => _error;

  set error(String error) {
    _error = error;
    notifyListeners();
  }

  final StudentService _studentService = StudentService();

  List<charts.Series<Week, String>> _delaymentsMonthSeriesList;
  List<charts.Series<Week, String>> get delaymentsMonthSeriesList =>
      _delaymentsMonthSeriesList;
  set delaymentsMonthSeriesList(List<charts.Series<Week, String>> series) {
    _delaymentsMonthSeriesList = series;
    notifyListeners();
  }

  Future<void> getMonthdelayments() async {
    try {
      List<Attendment> delaymentList =
          await _studentService.getAttendments(1247);

      delaymentList
          .sort((Attendment a1, Attendment a2) => a1.date.compareTo(a2.date));
      List<Week> weeks = getWeeksInAMonth(
          delaymentList[0].date.year, delaymentList[0].date.month);

      Map<String, Object> data = calculateMonthData(weeks, delaymentList);
      weeks = data['weeks'];
      MonthData monthData = data['monthData'];
      totalDelayments = monthData.totalDelayments;

      delaymentsMonthSeriesList = getDelaymentseries(weeks);

      notifyListeners();
    } on Exception catch (e) {
      error = e.toString();
    }
  }

  List<charts.Series<Week, String>> getDelaymentseries(List<Week> list) {
    List<charts.Series<Week, String>> series = <charts.Series<Week, String>>[
      charts.Series<Week, String>(
        id: 'Retrasos',
        data: list,
        seriesColor: charts.Color.fromHex(code: '#F06C79'),
        domainFn: (Week datum, int index) => 'S${index + 1}',
        measureFn: (Week datum, _) => datum.weekDelayments,
      ),
    ];
    return series;
  }
}
