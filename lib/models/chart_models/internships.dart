import 'package:flutter/cupertino.dart';

class Internship {
  Internship({
    this.noInternship,
    this.withInternship,
  });

  factory Internship.fromMap(Map<String, dynamic> map) => Internship(
        noInternship: List<InternshipLevel>.from(
            map['lista_no_practicas']?.map((_) => InternshipLevel.fromMap(_))),
        withInternship: List<InternshipLevel>.from(
            map['lista_practicas']?.map((_) => InternshipLevel.fromMap(_))),
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
        students: int.parse(map['alumnos'].toString()),
      );

  String level;
  int students;
}
