import 'dart:convert';

import 'package:tizatech/models/user.dart';

class Courses {
  Courses({
    this.name,
    this.code,
    this.letter,
    this.studentList,
    this.subjectList,
  });

  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      name: map['grado']['name'],
      code: map['codigo'],
      letter: map['letra'],
      studentList: List<Student>.from(
          map['alumnos']?.map((dynamic x) => Student.fromMap(x))),
      subjectList: List<TeacherSubject>.from(
          map['asignaturas']?.map((dynamic x) => TeacherSubject.fromMap(x))),
    );
  }

  factory Courses.fromJson(String source) =>
      Courses.fromMap(json.decode(source));

  final String name;
  final String code;
  final String letter;
  final List<Student> studentList;
  final List<TeacherSubject> subjectList;
}

class TeacherSubject {
  TeacherSubject({
    this.id,
    this.name,
    this.code,
  });
  factory TeacherSubject.fromMap(Map<String, dynamic> map) {
    print(map);
    return TeacherSubject(
      id: map['id'],
      name: map['name'],
      code: map['codigo'],
    );
  }

  factory TeacherSubject.fromJson(String source) =>
      TeacherSubject.fromMap(json.decode(source));

  final int id;
  final String name;
  final String code;
}
