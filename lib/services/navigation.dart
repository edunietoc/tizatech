import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BuildContext get currentContext => _navigatorKey.currentContext;
}

class Routes {
  Routes._();

  static const String loader = '/loader';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String grades = '/grades';
  static const String messages = '/messages';
  static const String assistance = '/assistance';
  static const String delayments = '/delayments';
  static const String books = '/books';
  static const String notifications = '/notifications';
  static const String login = '/login';
  static const String studentList = '/student_list';
  static const String courses = '/courses';
  static const String charts = '/charts';
  static const String teacherStudentList = '/teacher_student_list';
  static const String teacherGradesList = '/teacher_grades_list';
  static const String teacherSubjectList = '/teacher_subject_list';
  static const String teacherFilterSubject = '/teacher_filter_subject';

  static const String searchTeacher = '/searchTeacher';
}
