import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';

import '../../../../models/chart_models/ptu.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  error,
  done,
  loading,
}

enum PTUType {
  language,
  math,
  science,
  men,
  mandatory,
  ranking,
}

class PTUViewModel extends ChangeNotifier {
  PTUViewModel() {
    _getPTU();
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

  PTU _ptu;

  PTU get ptu => _ptu;

  Future<void> _getPTU() async {
    try {
      _ptu = await _chartsService.getPTU();
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<PTUData> _getListByType(PTUType type) {
    Map<PTUType, List<PTUData>> map = <PTUType, List<PTUData>>{
      PTUType.language: _ptu.languageList,
      PTUType.math: _ptu.mathList,
      PTUType.science: _ptu.scienceList,
      PTUType.men: _ptu.menList,
      PTUType.mandatory: _ptu.mandatoryList,
      PTUType.ranking: _ptu.rankingList,
    };

    return map[type];
  }

  List<charts.Series<PTUData, String>> getDataSeries(PTUType type) =>
      <charts.Series<PTUData, String>>[
        charts.Series<PTUData, String>(
          id: 'Anual Repeating Students',
          data: _getListByType(type),
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (PTUData datum, int index) => datum.scoreLabel,
          measureFn: (PTUData datum, _) => datum.students,
        )
      ];
}
