import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
          buttonText: 'auth.errorButton'.tr(),
          description: 'auth.errorDescription'.tr(),
          title: 'auth.errorTitle'.tr(),
          onPressed: () => Navigator.pop(context));
    }
  }
}
