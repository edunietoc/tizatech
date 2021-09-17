import 'dart:convert';

import 'package:flutter/foundation.dart';

class AttendmentModule {
  AttendmentModule({
    @required this.id,
    @required this.name,
  });
  factory AttendmentModule.fromJson(String source) =>
      AttendmentModule.fromMap(json.decode(source));
  factory AttendmentModule.fromMap(Map<String, dynamic> map) =>
      AttendmentModule(
        id: map['id'].toString(),
        name: map['name'],
      );

  String id;
  String name;
}
