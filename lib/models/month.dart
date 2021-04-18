import 'dart:convert';

import 'attendments.dart';

class Month {
  Month({
    this.month,
    this.attendements,
    this.unnatendments,
    this.delayments,
    this.attendmentList,
  });
  factory Month.fromMap(Map<String, dynamic> map) => Month(
        month: map['mes'].toString().toLowerCase(),
        attendements: map['asistencias'],
        unnatendments: map['inasistencias'],
        delayments: map['atrasos'],
        attendmentList: List<Attendment>.from(
            map['lista'].map((dynamic x) => Attendment.fromMap(x))),
      );

  factory Month.fromJson(String source) => Month.fromMap(json.decode(source));

  String month;
  int attendements;
  int unnatendments;
  int delayments;
  List<Attendment> attendmentList;

  int get monthNumber {
    switch (month) {
      case 'enero':
        return 1;
      case 'febrero':
        return 2;
      case 'marzo':
        return 3;
      case 'abril':
        return 4;
      case 'mayo':
        return 5;
      case 'junio':
        return 6;
      case 'julio':
        return 7;
      case 'agosto':
        return 8;
      case 'septiembre':
        return 9;
      case 'octubre':
        return 10;
      case 'novimebre':
        return 11;
      case 'diciembre':
        return 12;
      default:
        return 0;
    }
  }
}
