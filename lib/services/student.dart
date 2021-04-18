import 'package:tizatech/models/book.dart';
import 'package:tizatech/models/month.dart';

import '../models/attendments.dart';
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
      print(response);
      return monthList;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> getStudentGrades(int id, [DateTime yyyy]) async {
    int year = yyyy ?? DateTime.now().year;
    String endpoint = 'notas/alumno/$id';
    try {
      dynamic response = await _api.getRequest(endpoint);
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
      print(bookList.last);
      return bookList;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
