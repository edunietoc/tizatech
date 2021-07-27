import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../models/chart_models/repeating.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  done,
  error,
}

class RepeatingViewModel extends ChangeNotifier {
  final ChartsService _chartsService = ChartsService();

  Status _currentStatus = Status.loading;
  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  String _error;
  String get error => _error;

  RepeatingStudents _repeatingStudents;
  RepeatingStudents get repeatingStudents => _repeatingStudents;

  Future<void> getRepeatingStudents() async {
    try {
      _repeatingStudents = await _chartsService.getRepeatingStudents();
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<RepeatingByYear, String>> getAnualSeries() =>
      <charts.Series<RepeatingByYear, String>>[
        charts.Series<RepeatingByYear, String>(
          id: 'Anual Repeating Students',
          data: _repeatingStudents.anualList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (RepeatingByYear datum, int index) => datum.date,
          measureFn: (RepeatingByYear datum, _) => datum.approved,
        )
      ];

  List<charts.Series<RepeatingByLevel, String>> getLevelSeries() =>
      <charts.Series<RepeatingByLevel, String>>[
        charts.Series<RepeatingByLevel, String>(
          id: 'Anual Repeating Students',
          data: _repeatingStudents.levelList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (RepeatingByLevel datum, int index) =>
              datum.levels[0].level,
          measureFn: (RepeatingByLevel datum, _) => datum.levels[0].approved,
        )
      ];
}
