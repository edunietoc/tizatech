import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../models/chart_models/simce.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  error,
  done,
}

class SimceViewModel extends ChangeNotifier {
  SimceViewModel() {
    getEssayScore();
  }

  final ChartsService _chartsService = ChartsService();
  Status _currentStatus = Status.loading;

  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  SimceScore _simceEssay;

  String _error;

  String get error => _error;

  Future<void> getEssayScore() async {
    try {
      _simceEssay = await _chartsService.getSimceEssay();
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<SimceSubject, num>> getLanguageSeries() =>
      <charts.Series<SimceSubject, num>>[
        charts.Series<SimceSubject, num>(
          id: 'Anual Attendance',
          data: _simceEssay.languageScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) => int.parse(datum.date),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];

  List<charts.Series<SimceSubject, num>> getMathSeries() =>
      <charts.Series<SimceSubject, num>>[
        charts.Series<SimceSubject, num>(
          id: 'Anual Attendance',
          data: _simceEssay.mathScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) => int.parse(datum.date),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];

  List<charts.Series<SimceSubject, num>> getHistorySeries() =>
      <charts.Series<SimceSubject, num>>[
        charts.Series<SimceSubject, num>(
          id: 'Anual Attendance',
          data: _simceEssay.historyScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) => int.parse(datum.date),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];

  List<charts.Series<SimceSubject, num>> getScienceSeries() =>
      <charts.Series<SimceSubject, num>>[
        charts.Series<SimceSubject, num>(
          id: 'Anual Attendance',
          data: _simceEssay.scienceScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) => int.parse(datum.date),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];
}
