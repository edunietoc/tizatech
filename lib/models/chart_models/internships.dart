import 'package:flutter/cupertino.dart';

class Internship {
  Internship({
    this.noInternship,
    this.withInternship,
  });

  factory Internship.fromMap(Map<String, dynamic> map) => Internship(
        noInternship: List<InternshipLevel>.from(
            map['noInternship']?.map((_) => InternshipLevel.fromMap(_))),
        withInternship: List<InternshipLevel>.from(
            map['withInternship']?.map((_) => InternshipLevel.fromMap(_))),
      );
  List<InternshipLevel> noInternship;
  List<InternshipLevel> withInternship;
}

class InternshipLevel {
  InternshipLevel({
    @required this.level,
    @required this.students,
  });

  factory InternshipLevel.fromMap(Map<String, dynamic> map) => InternshipLevel(
        level: map['grado'],
        students: map['alumnos'],
      );

  String level;
  int students;
}
