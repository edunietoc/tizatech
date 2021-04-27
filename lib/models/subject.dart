import 'dart:convert';

import 'package:flutter/material.dart';

class Subject {
  Subject({
    this.name,
    this.grades,
    this.key,
    this.average,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    List<double> gradesList = List<double>.from(
      map['notas'].map(
        (dynamic e) => double.tryParse(
          e['nota'],
        ),
      ),
    ).toList();

    return Subject(
      name: map['name'].toString().toLowerCase(),
      grades: gradesList,
      average: gradesList.fold(
              double.parse('0'),
              (double previousValue, double element) =>
                  element + previousValue) /
          gradesList.length,
    );
  }

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source));

  String name;
  List<double> grades;
  GlobalKey key;
  double average;
}
