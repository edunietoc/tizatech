import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../../models/chart_models/personal_improvement.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  done,
  error,
}

class PersonalImpViewModel extends ChangeNotifier {
  PersonalImpViewModel() {
    _getPersonalImp();
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

  PersonalImprovement _personalImprovement;
  PersonalImprovement get personalImprovement => _personalImprovement;

  Future<void> _getPersonalImp() async {
    try {
      _personalImprovement = await _chartsService.getPersonalImprovement();
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<charts.Series<PersonalImprovementIndicator, String>> getDataSeries() =>
      <charts.Series<PersonalImprovementIndicator, String>>[
        charts.Series<PersonalImprovementIndicator, String>(
          id: 'Anual Repeating Students',
          data: _personalImprovement.pIList,
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (PersonalImprovementIndicator datum, int index) =>
              datum.course,
          measureFn: (PersonalImprovementIndicator datum, _) =>
              datum.values[0].value,
        )
      ];
}
