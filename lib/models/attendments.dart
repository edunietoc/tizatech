import 'dart:convert';

import 'package:flutter/material.dart';

class Attendment {
  Attendment({
    @required this.date,
    @required this.didAttend,
    @required this.isDelayed,
  });

  factory Attendment.fromMap(Map<String, dynamic> map) => Attendment(
        date: DateTime.parse(map['date']),
        didAttend: map['asistencia'],
        isDelayed: map['retraso'],
      );

  factory Attendment.fromJson(String source) =>
      Attendment.fromMap(json.decode(source));
  final DateTime date;
  final bool isDelayed;
  final bool didAttend;

  Map<String, dynamic> toMap() => <String, dynamic>{
        /* 'date': date.millisecondsSinceEpoch, */

        'didAttend': didAttend,
      };

  String toJson() => json.encode(toMap());
}
