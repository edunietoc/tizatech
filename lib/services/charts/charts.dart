import 'package:flutter/cupertino.dart';
import 'package:tizatech/models/chart_models/internships.dart';
import 'package:tizatech/models/chart_models/personal_improvement.dart';
import 'package:tizatech/models/chart_models/ptu.dart';
import 'package:tizatech/models/chart_models/repeating.dart';

import '../../models/chart_models/annotations.dart';
import '../../models/chart_models/attendace.dart';
import '../../models/chart_models/enrollment.dart';
import '../../models/chart_models/simce.dart';
import '../api.dart';

class ChartsService {
  final API _api = API();

  final int year = DateTime.now().year;

  Future<AttendanceBase> getAttendance() async {
    try {
      dynamic response = await _api.getRequest('graficas/asistencias/$year');
      return AttendanceBase.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<AttendanceBase> getUnattendance() async {
    try {
      dynamic response = await _api.getRequest('graficas/inasistencias/$year');
      return AttendanceBase.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<AttendanceBase> getDelayment() async {
    try {
      dynamic response = await _api.getRequest('graficas/retrasos/$year');
      return AttendanceBase.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<SimceScore> getSimceEssay() async {
    try {
      dynamic response = await _api.getRequest('graficas/puntaje-ensayo-simce');
      return SimceScore.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<SimceScore> getSimceScore() async {
    try {
      dynamic response =
          await _api.getRequest('graficas/puntajes-simce-colegio/');
      return SimceScore.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Enrollment> getEnrollment() async {
    try {
      dynamic response =
          await _api.getRequest('graficas/matricula-actual/$year');
      return Enrollment.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Annotations> getAnnotations() async {
    try {
      dynamic response =
          await _api.getRequest('graficas/alumnos-no-convivencia/$year');
      return Annotations.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<PTU> getPTU() async {
    try {
      dynamic response = await _api.getRequest('graficas/ptu/');
      return PTU.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<RepeatingStudents> getRepeatingStudents() async {
    try {
      dynamic response =
          await _api.getRequest('graficas/repitencia-ultimo/$year/');
      return RepeatingStudents.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<PersonalImprovement> getPersonalImprovement() async {
    try {
      dynamic response = await _api
          .getRequest('graficas/indicadores-desarrollo-personal/$year/');
      return PersonalImprovement.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<Internship> getInternships() async {
    try {
      dynamic response =
          await _api.getRequest('graficas/alumnos-practicas/$year/');
      return Internship.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
