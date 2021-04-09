import 'dart:convert';

import 'package:flutter/material.dart';

class Attendments {
  Attendments({
    @required this.date,
    @required this.didAttend,
  });

  factory Attendments.fromMap(Map<String, dynamic> map) => Attendments(
        date: DateTime.parse(map['date']),
        didAttend: map['asistencia'],
      );

  factory Attendments.fromJson(String source) =>
      Attendments.fromMap(json.decode(source));
  DateTime date;
  bool isDelayed;
  bool didAttend;

  Map<String, dynamic> toMap() => <String, dynamic>{
        /* 'date': date.millisecondsSinceEpoch, */

        'didAttend': didAttend,
      };

  String toJson() => json.encode(toMap());
}
