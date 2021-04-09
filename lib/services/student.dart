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
}
