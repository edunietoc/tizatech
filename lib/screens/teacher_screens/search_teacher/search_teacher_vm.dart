import 'package:flutter/material.dart';

import '../../../locator/locator.dart';
import '../../../models/user.dart';
import '../../../services/navigation.dart';
import '../../../services/teacher.dart';
import 'teacher_list.dart';

enum Status {
  loading,
  done,
  error,
}

class SearchTeacherViewModel extends ChangeNotifier {
  final TeacherServices _teacherServices = TeacherServices();
  Status _currentStatus = Status.done;

  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  String _error;

  String get error => _error;

  String firstName;
  String lastName;
  String rut;

  Future<void> search() async {
    try {
      BuildContext context = locator<NavigationService>().currentContext;
      currentStatus = Status.loading;
      List<Teacher> teacherList = await _teacherServices.searchTeacher(
        firstName: firstName,
        lastName: lastName,
        rut: rut,
      );

      currentStatus = Status.done;

      await Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => TeacherListScreen(teacherList: teacherList),
          ));
    } on Exception catch (e) {
      _error = e.toString();
      print(_error);
      currentStatus = Status.error;
    }
  }
}
