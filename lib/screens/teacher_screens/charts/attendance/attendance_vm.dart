import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../models/chart_models/attendace.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  done,
  error,
}

class AttendanceViewModel extends ChangeNotifier {
  AttendanceViewModel() {
    getAttendance();
  }

  final ChartsService _chartsService = ChartsService();

  Status _currentStatus = Status.loading;

  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  String _error;

  String get error => _error;

  AttendanceBase _attendance;

  Future<void> getAttendance() async {
    try {
      _attendance = await _chartsService.getAttendance();
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<AttendanceAnualMonth, String>> getAnualSeries() => [
        charts.Series<AttendanceAnualMonth, String>(
          id: 'Anual Attendance',
          data: _attendance.anualList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (AttendanceAnualMonth datum, int index) => datum.month,
          measureFn: (AttendanceAnualMonth datum, _) => int.parse(datum.value),
        )
      ];

  List<charts.Series<AttendanceMonthDay, String>> getMonthSeries() => [
        charts.Series<AttendanceMonthDay, String>(
          id: 'Anual Attendance',
          data: _attendance.mensualList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (AttendanceMonthDay datum, int index) => datum.courseName,
          measureFn: (AttendanceMonthDay datum, _) => int.parse(datum.value),
        )
      ];

  List<charts.Series<AttendanceMonthDay, String>> getDailySeries() => [
        charts.Series<AttendanceMonthDay, String>(
          id: 'Anual Attendance',
          data: _attendance.todayList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (AttendanceMonthDay datum, int index) => datum.courseName,
          measureFn: (AttendanceMonthDay datum, _) => int.parse(datum.value),
        )
      ];

  List<charts.Series<AttendanceMonthDay, String>> getLevelSeries() => [
        charts.Series<AttendanceMonthDay, String>(
          id: 'Anual Attendance',
          data: _attendance.levelList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (AttendanceMonthDay datum, int index) => datum.courseName,
          measureFn: (AttendanceMonthDay datum, _) => int.parse(datum.value),
        )
      ];
}
