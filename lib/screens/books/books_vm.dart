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

  String _error;

  String get error => _error;
  set error(String error) => _error = error;

  Status _currentStatus;

  Status get currentStatus => _currentStatus;

  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  List<Book> bookList;

  Future<void> init() async {
    try {
      currentStatus = Status.loading;
      int id = locator<UserService>().user.id;
      bookList = await _studentService.getBooks(id);
      currentStatus = Status.done;
    } on Exception catch (e) {
      error = e.toString();
      currentStatus = Status.error;
    }
  }

  Future<void> launchUrl(String url) async {
    try {
      await launchURL(url);
    } on Exception catch (e) {
      error = e.toString();
      currentStatus = Status.error;
    }
  }
}
