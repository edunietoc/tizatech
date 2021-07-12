import 'package:flutter/material.dart';

import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/courses.dart';
import '../../../models/take_attendment.dart';
import '../../../models/user.dart';
import '../../../services/teacher.dart';

enum Status {
  loading,
  done,
  error,
}

class TakeAttendmentViewModel extends ChangeNotifier {
  TakeAttendmentViewModel({
    this.code,
    this.course,
  });

  final String code;
  final Courses course;

  final TeacherServices _teacherServices = TeacherServices();
  final Teacher _user = locator<UserService>().user;
  List<Student> _unMarkedStudents = <Student>[];

  List<Student> get unMarkedStudents => _unMarkedStudents;

  String _error;

  String get error => _error;

  Status _currentStatus = Status.done;

  void addItem(Student stud) {
    if (studentExist(stud)) {
      _unMarkedStudents.remove(stud);
    } else {
      _unMarkedStudents.add(stud);
    }

    print(_unMarkedStudents);
    notifyListeners();
  }

  bool studentExist(Student stud) =>
      _unMarkedStudents.firstWhere((Student student) => student.id == stud.id,
          orElse: () => null) !=
      null;

  Future<void> uploadAttendments() async {
    try {
      int contentType = await _teacherServices.getContentType();

      print('content type: $contentType');
      Signature sign = Signature(
        contentType: contentType,
        signedBy: _user.id,
        validation: true,
        code: code,
      );

      int signatureID = await _teacherServices.signAttendment(sign);
      print('SIGNED');

      List<TakeAttendment> attendmentList = List<TakeAttendment>.generate(
        _unMarkedStudents.length,
        (int index) => TakeAttendment(
          date: DateTime.now(),
          didAttend: false,
          schedule: course.schedule,
          studentId: _unMarkedStudents[index].id.toString(),
          signature: signatureID,
        ),
      );

      await _teacherServices.uploadAttendments(attendmentList);
      print('DONE');
    } on Exception catch (e) {}
  }
}
