import 'package:flutter/material.dart';

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

  String _error;

  String get error => _error;

  List<GradesByStudent> get grades => _grades;

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
