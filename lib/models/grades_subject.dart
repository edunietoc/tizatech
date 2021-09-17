import 'package:flutter/material.dart';

import 'user.dart';

class GradesByStudent {
  GradesByStudent({
    this.student,
    this.grade,
    this.period,
    this.periodEnd,
    this.periodId,
    this.periodStart,
    this.key,
  });

  factory GradesByStudent.fromMap(Map<String, dynamic> map) => GradesByStudent(
        student: Student.fromMap(map['alumno']),
        grade: double.tryParse(map['nota']),
        period: map['evaluacion']['periodo']['name'],
        periodEnd: DateTime.tryParse(map['evaluacion']['periodo']['end_date']),
        periodStart:
            DateTime.tryParse(map['evaluacion']['periodo']['start_date']),
        periodId: int.tryParse(map['evaluacion']['periodo']['id'].toString()),
      );

  Student student;
  double grade;
  GlobalKey key;
  final String period;
  final DateTime periodStart;
  final DateTime periodEnd;
  final int periodId;
}
