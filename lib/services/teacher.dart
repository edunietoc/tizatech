import 'package:flutter/material.dart';

import '../models/courses.dart';
import '../models/grades_subject.dart';
import 'api.dart';

class TeacherServices {
  final API _api = API();

  Future<List<Courses>> getCourses(String id) async {
    String endpoint = 'cursos/profesor/$id';
    try {
      dynamic response = await _api.getRequest(endpoint);
      List<dynamic> responseList = response;

      List<Courses> courseList = responseList
          ?.map((dynamic course) => Courses.fromMap(course))
          ?.toList();

      return courseList;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<GradesByStudent>> getGrades(int subjectID) async {
    String endpoint = 'notas/asignatura/$subjectID';
    try {
      dynamic response = await _api.getRequest(endpoint);

      return (response as List<dynamic>)
          .map((dynamic grade) => GradesByStudent.fromMap(grade))
          .toList()
            ..forEach((GradesByStudent element) => element.key = GlobalKey());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
