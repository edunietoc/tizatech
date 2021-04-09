import 'package:tizatech/models/attendments.dart';

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

  Future<List<Attendments>> getAttendments(int id) async {
    String endpoint = 'asistencias/alumno/$id/';
    print('ruuning');
    try {
      dynamic response = await _api.getRequest(endpoint);

      List list = response;

      List<Attendments> attendmentsList = List<Attendments>.generate(
        list.length,
        (int index) => Attendments.fromMap(
          list[index],
        ),
      );
      return attendmentsList;

      print(attendmentsList);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future getStudentGrades(int id) async {
    String endpoint = 'notas/alumno/$id';
    try {
      dynamic response = await _api.getRequest(endpoint);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
