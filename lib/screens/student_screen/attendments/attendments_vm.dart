import 'dart:io';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/attendments.dart';
import '../../../models/month.dart';
import '../../../models/user.dart';
import '../../../models/week.dart';
import '../../../services/student.dart';

enum Status {
  loading,
  done,
  error,
}

class AttendementsViewModel extends ChangeNotifier {
  AttendementsViewModel({User userParam}) {
    user = userParam ?? locator<UserService>().user;
  }

  //---------------------DEPENDECIES--------------------------------------------

  final StudentService _studentService = StudentService();
  User user;

  //-----------------------VARIABLES--------------------------------------------
  String _errorTitle;
  String _errorDescription;
  String _errorImage;
  int totalMonthAttendments;
  int totalYearAttendments;
  int totalMonthUnattendments;
  int totalYearUnattendments;
  List<charts.Series<Week, String>> _monthSeriesList;
  List<charts.Series<Month, String>> _yearSeriesList;
  Status _currentStatus = Status.loading;

  //------------------------GETTERS & SETTERS-----------------------------------
  String get errorTitle => _errorTitle;
  String get errorDescription => _errorDescription;
  String get errorImage => _errorImage;

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

  Future<void> getMonthAttendments(List<Month> monthList) async {
    try {
      Month currentMonth = monthList.singleWhere(
          (Month element) => element.monthNumber == DateTime.now().month,
          orElse: () => throw Exception('No_info'));

      totalMonthAttendments = currentMonth.attendements;
      totalMonthUnattendments = currentMonth.unnatendments;

      currentMonth.attendmentList
          .sort((Attendment a1, Attendment a2) => a1.date.compareTo(a2.date));

      List<Week> weeks = getWeeksInAMonth(
          currentMonth.attendmentList[0].date.year, currentMonth.monthNumber);

      weeks = calculateMonthData(weeks, currentMonth.attendmentList);

      monthSeriesList = getMonthSeries(weeks);
    } on Exception catch (_) {
      rethrow;
    }
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
      int id = user.id;
      List<Month> monthList = await _studentService.getAttendments(id);
      print('meses: ${monthList.length}');
      await getMonthAttendments(monthList);
      getYearAttendments(monthList);
      currentStatus = Status.done;
    } on Exception catch (e) {
      if (e.toString().contains('No_info')) {
        _errorTitle = 'No hay Resultados';
        _errorImage = 'assets/images/grades/no_grades.png';
        _errorDescription =
            'Tus asistencias no han sido cargadas, por favor intenta consultarlas más tarde.';
      } else if (e is SocketException) {
        _errorTitle = 'Error en la Conexion';
        _errorImage = 'assets/images/error/connection_error.png';
        _errorDescription =
            'Por favor verifique que su conexión de intenet es estable o vuelva a intentarlo más tarde.';
      } else {
        _errorTitle = 'Error al mostrar';
        _errorImage = 'assets/images/error/unknown_error.png';
        _errorDescription =
            'Ocurrio un error al mostrar este Contenido, por favor intentalo más tarde o contacta a tu Institución.';
      }
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
