import 'package:flutter/material.dart';
import 'package:tizatech/models/courses.dart';

class SubjectListViewModel extends ChangeNotifier {
  SubjectListViewModel({
    @required this.currentCourse,
  });

  final Courses currentCourse;
}
