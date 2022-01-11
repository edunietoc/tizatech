import 'package:flutter/material.dart';

import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/courses.dart';
import '../../../models/user.dart';
import '../../../services/navigation.dart';
import '../../../services/teacher.dart';
import '../course_menu/course_menu.dart';

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

  int _currentIndexCourse;

  int get currentIndexCourse => _currentIndexCourse;
  set currentIndexCourse(int course) {
    _currentIndexCourse = course;
    notifyListeners();
  }

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
      _courseList = await _teacherServices.getCourses('${_teacher.id}');
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      print(_error);
      currentStatus = Status.error;
    }
  }

  void selectCourse() {
    BuildContext context = locator<NavigationService>().currentContext;

    Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (_) => TeacherCourseMenuScreen(
            course: _courseList[_currentIndexCourse],
          ),
        ));
  }
}
