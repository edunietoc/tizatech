import 'package:flutter/material.dart';
import 'package:tizatech/locator/locator.dart';
import 'package:tizatech/locator/user_service.dart';
import 'package:tizatech/models/book.dart';
import 'package:tizatech/services/student.dart';

class BooksViewModel extends ChangeNotifier {
  final StudentService _studentService = StudentService();

  String _error;

  String get error => _error;
  set error(String error) {
    _error = error;
    notifyListeners();
  }

  List<Book> bookList;

  Future<void> init() async {
    try {
      int id = locator<UserService>().user.id;
      bookList = await _studentService.getBooks(id);
      notifyListeners();
    } on Exception catch (e) {
      error = e.toString();
    }
  }
}
