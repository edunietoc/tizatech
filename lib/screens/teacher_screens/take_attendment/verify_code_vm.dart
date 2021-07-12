import 'package:flutter/material.dart';

import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/courses.dart';
import '../../../models/user.dart';
import '../../../services/navigation.dart';
import '../../../services/teacher.dart';
import 'take_attendment.dart';

enum Status {
  loading,
  done,
  error,
}

class TeacherVerifyCodeViewModel extends ChangeNotifier {
  TeacherVerifyCodeViewModel(this.course);

  final Courses course;

  final TeacherServices _teacherServices = TeacherServices();
  final Teacher _teacher = locator<UserService>().user;

  Status _currentStatus = Status.done;

  Status get currentStatus => _currentStatus;

  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  String _error;

  String get error => _error;

  String code;

  Future<void> verifyCode() async {
    try {
      currentStatus = Status.loading;
      bool accepted = await _teacherServices.codeValidation(
          code, '${_teacher.rut}-${_teacher.verifierDigit}');
      currentStatus = Status.done;

      if (true) {
        BuildContext context = locator<NavigationService>().currentContext;
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute<Widget>(
              builder: (_) => TeacherTakeAttendmentScreen(
                course: course,
                code: code,
              ),
            ));
      }
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }
}




//TODO: add this verfication
/*

Response from code
 [
{
"RUT": "12743479-4",
"O": 0,
"OTPVERIFY": false
}
] */
