import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../models/chart_models/simce.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  error,
  done,
}

enum SimceType {
  score,
  essay,
}

class SimceViewModel extends ChangeNotifier {
  SimceViewModel(this.simceType) {
    _dataFunction = {
      SimceType.essay: _chartsService.getSimceEssay(),
      SimceType.score: _chartsService.getSimceScore(),
    };

    getEssayScore();
  }

  final ChartsService _chartsService = ChartsService();
  Status _currentStatus = Status.loading;

  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  final SimceType simceType;

  Map<SimceType, Future<dynamic>> _dataFunction;

  SimceScore _simceEssay;

  String _error;

  String get error => _error;

  Future<void> getEssayScore() async {
    try {
      _simceEssay = await _dataFunction[simceType];
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<SimceSubject, DateTime>> getLanguageSeries() =>
      <charts.Series<SimceSubject, DateTime>>[
        charts.Series<SimceSubject, DateTime>(
          id: 'Anual Attendance',
          data: _simceEssay.languageScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) =>
              DateTime(int.tryParse(datum.date)),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];

  List<charts.Series<SimceSubject, DateTime>> getMathSeries() =>
      <charts.Series<SimceSubject, DateTime>>[
        charts.Series<SimceSubject, DateTime>(
          id: 'Anual Attendance',
          data: _simceEssay.mathScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) =>
              DateTime(int.tryParse(datum.date)),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];

  List<charts.Series<SimceSubject, DateTime>> getHistorySeries() =>
      <charts.Series<SimceSubject, DateTime>>[
        charts.Series<SimceSubject, DateTime>(
          id: 'Anual Attendance',
          data: _simceEssay.historyScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) =>
              DateTime(int.tryParse(datum.date)),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];

  List<charts.Series<SimceSubject, DateTime>> getScienceSeries() =>
      <charts.Series<SimceSubject, DateTime>>[
        charts.Series<SimceSubject, DateTime>(
          id: 'Anual Attendance',
          data: _simceEssay.scienceScore,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (SimceSubject datum, int index) =>
              DateTime(int.tryParse(datum.date)),
          measureFn: (SimceSubject datum, _) => double.parse(datum.score),
        )
      ];
}
