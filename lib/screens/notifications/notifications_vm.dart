import 'package:flutter/material.dart';

class NotificationsViewModel extends ChangeNotifier {
  bool notificationsEnabled = true;

  void toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    notifyListeners();
  }
}
