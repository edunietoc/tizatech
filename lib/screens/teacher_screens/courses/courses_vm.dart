import 'package:flutter/material.dart';

import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/courses.dart';
import '../../../models/user.dart';
import '../../../services/teacher.dart';

enum Status {
  loading,
  error,
  done,
}

class CoursesViewModel extends ChangeNotifier {
  CoursesViewModel() {
    getCourses();
  }

  final Teacher _teacher = locator<UserService>().user;
  final TeacherServices _teacherServices = TeacherServices();

  List<Courses> _courseList;
  Status _currentStatus = Status.loading;

  String _error;

  Teacher get teacher => _teacher;

  List<Courses> get courseList => _courseList;

  Status get currentStatus => _currentStatus;

  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  String get error => _error;

  Future<void> getCourses() async {
    try {
      print('Running');
      _courseList = await _teacherServices.getCourses('${_teacher.id}');
      currentStatus = Status.done;
    } on Exception catch (e) {
      print(e.toString());
      _error = e.toString();
      currentStatus = Status.error;
    }
  }
}
