import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../models/chart_models/enrollment.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  done,
  error,
}

class EnrollmentViewModel extends ChangeNotifier {
  EnrollmentViewModel() {
    _getEnrrollment();
  }
  final ChartsService _chartsService = ChartsService();

  Status _currentStatus = Status.loading;

  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  Enrollment _enrollment;

  String _error;

  String get error => _error;

  Future<void> _getEnrrollment() async {
    try {
      _enrollment = await _chartsService.getEnrollment();
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<AnualEnrollment, String>> getAnualSeries() =>
      <charts.Series<AnualEnrollment, String>>[
        charts.Series<AnualEnrollment, String>(
          id: 'Anual Attendance',
          data: _enrollment.anualList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (AnualEnrollment datum, int index) => datum.year,
          measureFn: (AnualEnrollment datum, _) => int.parse(datum.total),
        )
      ];

  List<charts.Series<CategoryEnrollment, String>> getCoursesSeries() =>
      <charts.Series<CategoryEnrollment, String>>[
        charts.Series<CategoryEnrollment, String>(
          id: 'Anual Attendance',
          data: _enrollment.courseList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (CategoryEnrollment datum, int index) => datum.category,
          measureFn: (CategoryEnrollment datum, _) => int.parse(datum.value),
        )
      ];

  List<charts.Series<CategoryEnrollment, String>> getLevelSeries() =>
      <charts.Series<CategoryEnrollment, String>>[
        charts.Series<CategoryEnrollment, String>(
          id: 'Anual Attendance',
          data: _enrollment.levelList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (CategoryEnrollment datum, int index) => datum.category,
          measureFn: (CategoryEnrollment datum, _) => int.parse(datum.value),
        )
      ];

  List<charts.Series<GenderEnrollment, String>> getGenderSeries() =>
      <charts.Series<GenderEnrollment, String>>[
        charts.Series<GenderEnrollment, String>(
          id: 'Anual Attendance',
          data: _enrollment.genderList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (GenderEnrollment datum, int index) => datum.gender,
          measureFn: (GenderEnrollment datum, _) => int.parse(datum.total),
        )
      ];
}
