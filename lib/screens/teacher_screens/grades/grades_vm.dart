import 'package:flutter/material.dart';
import 'package:tizatech/_components/dropdown.dart';

import '../../../models/courses.dart';
import '../../../models/grades_subject.dart';
import '../../../services/teacher.dart';

enum Status {
  loading,
  done,
  error,
}

class TeacherGradesViewModel extends ChangeNotifier {
  TeacherGradesViewModel(this._currentSubject) {
    _getGrades();
  }

  final TeacherServices _teacherServices = TeacherServices();

  final TeacherSubject _currentSubject;

  List<GradesByStudent> _grades;

  Status _currentStatus = Status.loading;

  int _selectedPeriodId = 1;

  int get selectedPeriodId => _selectedPeriodId;

  set selectedPeriodId(int id) {
    _selectedPeriodId = id;
    notifyListeners();
  }

  List<Option> get optionList => periodList.map((periodId) {
        GradesByStudent grade =
            grades.firstWhere((grade) => grade.periodId == periodId);

        return Option(text: grade.period, value: grade.periodId);
      }).toList();

  List<int> get periodList => grades.map((_) => _.periodId).toSet().toList();

  String _error;

  String get error => _error;

  List<GradesByStudent> get grades => _grades;

  List<GradesByStudent> get gradesByPeriod => _grades
      .where(
          (GradesByStudent grade) => grade.periodId == _selectedPeriodId ?? 0)
      .toList();

  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  Future<void> _getGrades() async {
    try {
      _grades = await _teacherServices.getGrades(_currentSubject.id);

      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }
}
