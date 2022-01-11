import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tizatech/models/attendment_modules.dart';

import '../models/courses.dart';
import '../models/grades_subject.dart';
import '../models/take_attendment.dart';
import '../models/user.dart';
import '../shared/api.dart';
import '../shared/utils.dart';
import 'api.dart';

class TeacherServices {
  final API _api = API();

  Future<List<Courses>> getCourses(String id) async {
    String endpoint = 'cursos/profesor/$id';
    try {
      dynamic response = await _api.getRequest(endpoint);
      print(response);
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
      String error = _.toString();
      print(error);
      rethrow;
    }
  }

  Future<bool> codeValidation(String code, String rut) async {
    const String baseUrl = 'claveunicagobcl.firebaseapp.com';
    try {
      dynamic response = await _api.getRequestWithParams(
        baseUrl,
        <String, dynamic>{
          'otp': code,
          'rut': rut,
          'DateWithTimeZone': dateTimeWithTimeZone(),
        },
        '/verifyOTPFromSimple',
      );
      print(response);
      if (response.toString().contains('ERROR')) {
        throw Exception();
      } else if (response[0]['OTPVERIFY'].toString() == 'RUT_NO_EXISTE') {
        return false;
      } else {
        return response[0]['OTPVERIFY'];
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<int> getContentType() async {
    try {
      dynamic response =
          await _api.getRequest('contenttype/?modelname=asistencia');
      return int.parse(response[0]['id'].toString());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<int> signAttendment(Signature sign) async {
    try {
      dynamic response = await _api.post('firmas/', sign.toMap());
      return response['id'];
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> uploadAttendments(List<TakeAttendment> attendmentList) async {
    try {
      print('uploading');
      dynamic response = await _api.putRequest(
          'asistencia/bulk-update/',
          json.encode(attendmentList
              .map((TakeAttendment model) => model.toMap())
              .toList()));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<Teacher>> searchTeacher(
      {String firstName, String lastName, String rut}) async {
    try {
      dynamic response = await _api.getRequestWithParams(
          baseUrlHttp,
          <String, dynamic>{
            'first_name': firstName,
            'last_name': lastName,
            'rut': rut,
          },
          '/api/search/profesor/',
          isHttps: false);

      return List<Teacher>.generate((response as List<dynamic>).length,
          (int index) => Teacher.fromMap(response[index]));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<AttendmentModule>> getAttendmentsTodayModules(
      String subjectId) async {
    String endpoint = 'modulos/today/asignatura/$subjectId';
    try {
      dynamic response = await _api.getRequest(endpoint);
      return List<AttendmentModule>.generate((response as List<dynamic>).length,
          (int index) => AttendmentModule.fromMap(response[index]));
    } on Exception catch (_) {
      rethrow;
    }
  }
}





/*

Response from code
 [
{
"RUT": "12743479-4",
"O": 0,
"OTPVERIFY": false
}
] */