import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/month.dart';
import '../models/subject.dart';
import 'api.dart';

class StudentService {
  final API _api = API();

  Future<void> getProfileInfo(int id) async {
    String endpoint = 'alumnos/$id/';
    try {
      Map<String, dynamic> response = await _api.getRequest(endpoint);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<Month>> getAttendments(int id, [DateTime yyyy]) async {
    int year = yyyy ?? DateTime.now().year;
    String endpoint = 'asistencias/$year/$id';

    try {
      dynamic response = await _api.getRequest(endpoint);

      List<dynamic> list = response;

      List<Month> monthList = List<Month>.generate(
        list.length,
        (int index) => Month.fromMap(
          list[index],
        ),
      );

      return monthList;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<Subject>> getStudentGrades(int id, [DateTime yyyy]) async {
    int year = yyyy ?? DateTime.now().year;
    String endpoint = 'notas/$year/$id';
    try {
      dynamic response = await _api.getRequest(endpoint);

      List responseList = response;
      if (responseList.isEmpty) {
        throw Exception('No_info');
      }
      List<dynamic> list = response[0]['ListaAsignatura'];

      List<Subject> subjectList = list
          .map((dynamic subject) => Subject.fromMap(subject))
          .toList()
            ..forEach((Subject element) => element.key = GlobalKey());
      return subjectList;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<Book>> getBooks(int id) async {
    const String endpoint = 'lecturas';
    try {
      dynamic response = await _api.getRequest(endpoint);
      List<dynamic> list = response['results'];

      List<Book> bookList = list.map((dynamic e) => Book.fromMap(e)).toList();

      return bookList;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
