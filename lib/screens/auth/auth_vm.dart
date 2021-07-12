import 'package:flutter/material.dart';

import '../../_components/dialog.dart';
import '../../_components/loader.dart';
import '../../locator/locator.dart';
import '../../services/auth.dart';
import '../../services/navigation.dart';

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
      showLoader();
      await _authService.login(email, password);
      closeLoader();
      await Navigator.pushReplacementNamed(context, Routes.home);
    } on Exception catch (e) {
      Navigator.pop(context);
      loginError = e.toString();
      showMessageDialog(
          context: context,
          buttonText: 'Entendido',
          description:
              'Verifica que tus claves sean correctas o contacta a la Institución.',
          title: 'Usuario No Registrado',
          onPressed: () => Navigator.pop(context));
    }
  }
}
