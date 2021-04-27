import 'package:flutter/material.dart';

import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/subject.dart';
import '../../models/user.dart';
import '../../services/student.dart';

enum Status {
  loading,
  done,
  error,
}

class GradesViewModel extends ChangeNotifier {
  User user = locator<UserService>().user;
  final StudentService _studentService = StudentService();

  String _error;
  String get error => _error;
  set error(String error) => _error = error;

  List<Subject> subjectList;
  double gradeAverage;
  Status _currentStatus;

  Status get currentStatus => _currentStatus;

  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  Future<void> getStudentGrades() async {
    try {
      currentStatus = Status.loading;
      subjectList = await _studentService.getStudentGrades(user.id);
      gradeAverage = subjectList.fold(
          0,
          (double previousValue, Subject element) =>
              element.average + previousValue);
      gradeAverage /= subjectList.length;
      currentStatus = Status.done;
    } on Exception catch (e) {
      error = e.toString();
      currentStatus = Status.error;
    }
  }
}
