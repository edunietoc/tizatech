import 'package:flutter/material.dart';

class Subject {
  Subject({
    @required this.name,
    @required this.grades,
  });
  String name;
  List<double> grades;
}
