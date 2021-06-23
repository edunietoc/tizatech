import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:tizatech/models/chart_models/annotations.dart';

import '../../../../models/chart_models/attendace.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  done,
  error,
}

class AnnotationsViewModel extends ChangeNotifier {
  AnnotationsViewModel() {
    _getAnnotations();
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

  Annotations _annotations;

  Future<void> _getAnnotations() async {
    try {
      _annotations = await _chartsService.getAnnotations();
      print(_annotations.levelAnnotations.first.categories.first.name);
      print(_annotations.levelAnnotations.first.categories.first.value);
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<AnualAnnotation, String>> getAnualSeries() =>
      <charts.Series<AnualAnnotation, String>>[
        charts.Series<AnualAnnotation, String>(
          id: 'Anual Attendance',
          data: _annotations.anualAnnotations,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (AnualAnnotation datum, int index) => datum.type,
          measureFn: (AnualAnnotation datum, _) => int.parse(datum.total),
        )
      ];

  List<charts.Series<CourseAnnotation, String>> getCourseSeries() =>
      <charts.Series<CourseAnnotation, String>>[
        charts.Series<CourseAnnotation, String>(
          id: 'Anual Attendance',
          data: _annotations.courseAnnotations,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (CourseAnnotation datum, int index) => datum.category,
          measureFn: (CourseAnnotation datum, _) => int.parse(datum.value),
        )
      ];

  List<charts.Series<CategoryLevelAnnotation, String>> getLevelSeries() =>
      <charts.Series<CategoryLevelAnnotation, String>>[
        charts.Series<CategoryLevelAnnotation, String>(
          id: 'Anual Attendance',
          data: _annotations.levelAnnotations.first.categories,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (CategoryLevelAnnotation datum, int index) => datum.name,
          measureFn: (CategoryLevelAnnotation datum, int index) =>
              int.parse(datum.value),
        )
      ];

  List<charts.Series<CourseValue, String>> getMonthSeries() =>
      <charts.Series<CourseValue, String>>[
        charts.Series<CourseValue, String>(
          id: 'Anual Attendance',
          data: _annotations.monthlyAnnotations.first.values,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (CourseValue datum, int index) => datum.course,
          measureFn: (CourseValue datum, _) => int.parse(datum.total),
        )
      ];
}
