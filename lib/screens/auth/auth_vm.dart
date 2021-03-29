import 'package:flutter/material.dart';
import 'package:tizatech/locator/locator.dart';
import 'package:tizatech/services/navigation.dart';

import '../../services/auth.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String email;
  String password;

  String _loginError;
  String get loginError => _loginError;
  set loginError(String error) {
    _loginError = error;
    notifyListeners();
  }

  Future<void> login() async {
    BuildContext context = locator<NavigationService>().currentContext;
    try {
      await _authService.login(email, password);
      await Navigator.pushReplacementNamed(context, Routes.home);
    } on Exception catch (e) {
      loginError = e.toString();
    }
  }
}
