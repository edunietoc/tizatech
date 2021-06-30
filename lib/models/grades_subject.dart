import 'package:flutter/material.dart';

import 'user.dart';

class GradesByStudent {
  GradesByStudent({this.student, this.grade, this.key});

  factory GradesByStudent.fromMap(Map<String, dynamic> map) {
    return GradesByStudent(
      student: Student.fromMap(map['alumno']),
      grade: double.tryParse(map['nota']),
    );
  }
  Student student;
  double grade;
  GlobalKey key;
}
