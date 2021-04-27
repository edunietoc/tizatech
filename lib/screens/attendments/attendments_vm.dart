import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/attendments.dart';
import '../../models/month.dart';
import '../../models/week.dart';
import '../../services/student.dart';

enum Status {
  loading,
  done,
  error,
}

class AttendementsViewModel extends ChangeNotifier {
  //---------------------DEPENDECIES--------------------------------------------

  final StudentService _studentService = StudentService();

  //-----------------------VARIABLES--------------------------------------------
  String _error;
  int totalMonthAttendments;
  int totalYearAttendments;
  int totalMonthUnattendments;
  int totalYearUnattendments;
  List<charts.Series<Week, String>> _monthSeriesList;
  List<charts.Series<Month, String>> _yearSeriesList;
  Status _currentStatus = Status.loading;

  //------------------------GETTERS & SETTERS-----------------------------------
  String get error => _error;
  set error(String error) => _error = error;

  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  List<charts.Series<Week, String>> get monthSeriesList => _monthSeriesList;
  set monthSeriesList(List<charts.Series<Week, String>> series) {
    _monthSeriesList = series;
    notifyListeners();
  }

  List<charts.Series<Month, String>> get yearSeriesList => _yearSeriesList;
  set yearSeriesList(List<charts.Series<Month, String>> series) {
    _yearSeriesList = series;
    notifyListeners();
  }

  //-------------------------METHODS--------------------------------------------

  void getMonthAttendments(List<Month> monthList) {
    Month currentMonth = monthList.singleWhere(
        (Month element) => element.monthNumber == DateTime.now().month);

    totalMonthAttendments = currentMonth.attendements;
    totalMonthUnattendments = currentMonth.unnatendments;

    currentMonth.attendmentList
        .sort((Attendment a1, Attendment a2) => a1.date.compareTo(a2.date));

    List<Week> weeks = getWeeksInAMonth(
        currentMonth.attendmentList[0].date.year, currentMonth.monthNumber);

    weeks = calculateMonthData(weeks, currentMonth.attendmentList);

    monthSeriesList = getMonthSeries(weeks);
  }

  void getYearAttendments(List<Month> monthList) {
    totalYearAttendments = monthList.fold(0,
        (int previousValue, Month month) => previousValue + month.attendements);
    totalYearUnattendments = monthList.fold(
        0,
        (int previousValue, Month month) =>
            previousValue + month.unnatendments);
    yearSeriesList = getYearSeries(monthList);
  }

  Future<void> getAttendments() async {
    try {
      currentStatus = Status.loading;
      int id = locator<UserService>().user.id;
      List<Month> monthList = await _studentService.getAttendments(id);
      getMonthAttendments(monthList);
      getYearAttendments(monthList);
      currentStatus = Status.done;
    } on Exception catch (e) {
      error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<Week, String>> getMonthSeries(List<Week> list) {
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

  List<charts.Series<Month, String>> getYearSeries(List<Month> list) {
    List<charts.Series<Month, String>> series = <charts.Series<Month, String>>[
      charts.Series<Month, String>(
        id: 'Inasistencia',
        data: list,
        seriesColor: charts.Color.fromHex(code: '#F06C79'),
        domainFn: (Month datum, int index) => datum.month,
        measureFn: (Month datum, _) => datum.unnatendments,
      ),
      charts.Series<Month, String>(
        id: 'Asistencia',
        data: list,
        seriesColor: charts.Color.fromHex(code: '#42B0A6'),
        domainFn: (Month datum, int index) => datum.month,
        measureFn: (Month datum, _) => datum.attendements,
      ),
    ];
    return series;
  }
}
