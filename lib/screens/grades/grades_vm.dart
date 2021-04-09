import 'package:flutter/material.dart';

import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../services/student.dart';

class GradesViewModel extends ChangeNotifier {
  User user = locator<UserService>().user;
  final StudentService _studentService = StudentService();

  String _error;
  String get error => _error;
  set error(String error) {
    _error = error;
    notifyListeners();
  }

  Future<void> getStudentGrades() async {
    try {
      await _studentService.getStudentGrades(user.id);
    } on Exception catch (e) {
      error = e.toString();
    }
  }
}
