import 'package:tizatech/models/courses.dart';

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
}
