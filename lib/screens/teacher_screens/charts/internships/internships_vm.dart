import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../../models/chart_models/internships.dart';
import '../../../../services/charts/charts.dart';

enum Status {
  loading,
  done,
  error,
}

enum InternshipTypeData {
  noInternship,
  withInternship,
}

class IntershipsViewModel extends ChangeNotifier {
  final ChartsService _chartsService = ChartsService();

  Status _currentStatus = Status.loading;
  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  String _error;
  String get error => _error;

  Internship _internship;
  Internship get internship => _internship;

  Future<void> getPersonalImp() async {
    try {
      _internship = await _chartsService.getInternships();
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  List<InternshipLevel> _getInternshipByType(InternshipTypeData type) {
    Map<InternshipTypeData, List<InternshipLevel>> map = {
      InternshipTypeData.noInternship: _internship.noInternship,
      InternshipTypeData.withInternship: _internship.withInternship,
    };
    return map[type];
  }

  List<charts.Series<InternshipLevel, String>> getDataSeries(
          InternshipTypeData type) =>
      <charts.Series<InternshipLevel, String>>[
        charts.Series<InternshipLevel, String>(
          id: 'Anual Repeating Students',
          data: _getInternshipByType(type),
          seriesColor: charts.Color.fromHex(code: '#42B0A6'),
          domainFn: (InternshipLevel datum, int index) => datum.level,
          measureFn: (InternshipLevel datum, _) => datum.students,
        )
      ];
}
