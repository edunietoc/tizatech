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

  Future<List<Attendment>> getAttendments(int id) async {
    String endpoint = 'asistencias/alumno/$id/';

    try {
      dynamic response = await _api.getRequest(endpoint);

      List<dynamic> list = response;

      List<Attendment> attendmentsList = List<Attendment>.generate(
        list.length,
        (int index) => Attendment.fromMap(
          list[index],
        ),
      );
      return attendmentsList;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> getStudentGrades(int id) async {
    String endpoint = 'notas/alumno/$id';
    try {
      dynamic response = await _api.getRequest(endpoint);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
