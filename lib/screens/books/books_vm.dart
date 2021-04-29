import 'dart:io';

import 'package:flutter/material.dart';

import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/book.dart';
import '../../services/student.dart';
import '../../services/url_service.dart';

enum Status {
  loading,
  done,
  error,
}

class BooksViewModel extends ChangeNotifier {
  final StudentService _studentService = StudentService();

  String _errorTitle;
  String _errorDescription;
  String _errorImage;
  Status _currentStatus;
  List<Book> bookList;

  String get errorTitle => _errorTitle;
  String get errorDescription => _errorDescription;
  String get errorImage => _errorImage;

  Status get currentStatus => _currentStatus;

  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  Future<void> init() async {
    try {
      currentStatus = Status.loading;
      int id = locator<UserService>().user.id;
      bookList = await _studentService.getBooks(id);
      currentStatus = Status.done;
    } on Exception catch (e) {
      handleError(e);
    }
  }

  void handleError(Exception e) {
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

  Future<void> launchUrl(String url) async {
    try {
      await launchURL(url);
    } on Exception catch (e) {
      handleError(e);
    }
  }
}
