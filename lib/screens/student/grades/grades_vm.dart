import 'dart:io';

import 'package:flutter/material.dart';

import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/subject.dart';
import '../../../models/user.dart';
import '../../../services/student.dart';

enum Status {
  loading,
  done,
  error,
}

class GradesViewModel extends ChangeNotifier {
  User user = locator<UserService>().user;
  final StudentService _studentService = StudentService();

  String _errorTitle;
  String get errorTitle => _errorTitle;

  String _errorDescription;
  String get errorDescription => _errorDescription;

  String _errorImage;
  String get errorImage => _errorImage;

  List<Subject> subjectList;
  double gradeAverage;
  Status _currentStatus;

  Status get currentStatus => _currentStatus;

  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  Future<void> getStudentGrades() async {
    try {
      currentStatus = Status.loading;
      subjectList = await _studentService.getStudentGrades(user.id);
      gradeAverage = subjectList.fold(
          0,
          (double previousValue, Subject element) =>
              element.average + previousValue);
      gradeAverage /= subjectList.length;
      currentStatus = Status.done;
    } on Exception catch (e) {
      print('Error is $e');
      if (e.toString().contains('No_info')) {
        _errorTitle = 'No hay Resultados';
        _errorImage = 'assets/images/grades/no_grades.png';
        _errorDescription =
            'Tus asistencias no han sido cargadas, por favor intenta consultarlas más tarde.';
      } else if (e is SocketException) {
        _errorTitle = 'Error en la Conexion';
        _errorImage = 'assets/images/error/connection_error.png';
        _errorDescription =
            'Por favor verifique que su conexión de intenet es estable o vuelva a intentarlo más tarde.';
      } else {
        _errorTitle = 'Error al mostrar';
        _errorImage = 'assets/images/error/unknown_error.png';
        _errorDescription =
            'Ocurrio un error al mostrar este Contenido, por favor intentalo más tarde o contacta a tu Institución.';
      }

      currentStatus = Status.error;
    }
  }
}
