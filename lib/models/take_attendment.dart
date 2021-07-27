import 'package:flutter/material.dart';

import '../shared/utils.dart';

class TakeAttendment {
  TakeAttendment({
    @required this.date,
    @required this.didAttend,
    @required this.studentId,
    @required this.schedule,
    @required this.signature,
    this.isLate,
  });
  DateTime date;
  bool didAttend;
  String studentId;
  String schedule;
  int signature;
  bool isLate;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'date': dateOnly(date),
        'asistencia': didAttend.toString(),
        'alumno': studentId,
        'horario': schedule,
        'firma': signature.toString(),
        'retraso': isLate ?? false,
      };
}

class Signature {
  Signature({
    @required this.signedBy,
    @required this.contentType,
    this.code,
    this.validation,
  });

  factory Signature.fromMap(Map<String, dynamic> map) => Signature(
        signedBy: map['signed_by'],
        contentType: map['contenttype'],
        code: map['code'],
        validation: map['validation'],
      );

  int signedBy;
  int contentType;
  String code;
  bool validation;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'signed_by': signedBy.toString(),
        'contenttype': contentType.toString(),
        'token': code,
        'validation': validation.toString(),
      };
}
