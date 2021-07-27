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
  List<Student> _offStudents = <Student>[];
  List<Student> _lateStudents = <Student>[];

  List<Student> get offStudents => _offStudents;
  List<Student> get lateStudents => _lateStudents;

  String _error;

  String get error => _error;

  Status _currentStatus = Status.done;
  Status get currentStatus => _currentStatus;
  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  void addItem(Student stud, {bool modifyLateStudents = false}) {
    if (!modifyLateStudents) {
      if (isMarkedAsUnnatendance(stud)) {
        _offStudents.remove(stud);
      } else {
        _offStudents.add(stud);
        if (_lateStudents.contains(stud)) {
          _lateStudents.remove(stud);
        }
      }
    } else {
      if (isMarkedAsLate(stud)) {
        _lateStudents.remove(stud);
      } else {
        _lateStudents.add(stud);
        if (_offStudents.contains(stud)) {
          _offStudents.remove(stud);
        }
      }
    }

    notifyListeners();
  }

  bool isMarkedAsUnnatendance(Student stud) =>
      _offStudents.firstWhere((Student student) => student.id == stud.id,
          orElse: () => null) !=
      null;

  bool isMarkedAsLate(Student stud) =>
      _lateStudents.firstWhere((Student student) => student.id == stud.id,
          orElse: () => null) !=
      null;

  Future<void> uploadAttendments() async {
    try {
      currentStatus = Status.loading;
      int contentType = await _teacherServices.getContentType();

      Signature sign = Signature(
        contentType: contentType,
        signedBy: _user.id,
        validation: true,
        code: code,
      );

      int signatureID = await _teacherServices.signAttendment(sign);

      List<TakeAttendment> attendmentList = List<TakeAttendment>.generate(
        _offStudents.length,
        (int index) => TakeAttendment(
          date: DateTime.now(),
          didAttend: false,
          schedule: course.schedule,
          studentId: _offStudents[index].id.toString(),
          signature: signatureID,
        ),
      )..addAll(_lateStudents.map((Student student) => TakeAttendment(
            date: DateTime.now(),
            didAttend: true,
            schedule: course.schedule,
            studentId: student.id.toString(),
            signature: signatureID,
            isLate: true,
          )));

      await _teacherServices.uploadAttendments(attendmentList);
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }
}
