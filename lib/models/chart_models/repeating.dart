import 'package:flutter/cupertino.dart';

class RepeatingStudents {
  RepeatingStudents({
    this.anualList,
    this.levelList,
    this.rangeList,
  });

  factory RepeatingStudents.fromMap(Map<String, dynamic> map) =>
      RepeatingStudents(
        anualList: List<RepeatingByYear>.from(
            map['lista_repitientes']?.map((_) => RepeatingByYear.fromMap(_))),
        levelList: List<RepeatingByLevel>.from(map['lista_repitientes_nivel']
            ?.map((_) => RepeatingByLevel.fromMap(_))),
        rangeList: List<RepeatingByRange>.from(
            map['lista_rangos']?.map((_) => RepeatingByRange.fromMap(_))),
      );

  List<RepeatingByYear> anualList;
  List<RepeatingByLevel> levelList;
  List<RepeatingByRange> rangeList;
}

class RepeatingByYear {
  RepeatingByYear({
    this.date,
    this.approved,
    this.reproved,
  });

  factory RepeatingByYear.fromMap(Map<String, dynamic> map) => RepeatingByYear(
        date: map['date'],
        approved: double.parse(map['aprobacion'].toString()),
        reproved: double.parse(map['reprobacion'].toString()),
      );

  String date;
  double approved;
  double reproved;
}

class RepeatingByLevel {
  RepeatingByLevel({
    @required this.level,
    @required this.approved,
    @required this.reproved,
  });

  factory RepeatingByLevel.fromMap(Map<String, dynamic> map) =>
      RepeatingByLevel(
        level: map['category'],
        approved: double.parse(map['aprobacion'].toString()),
        reproved: double.parse(map['reprobacion'].toString()),
      );
  String level;
  double approved;
  double reproved;
}

class RepeatingByRange {
  RepeatingByRange({
    @required this.range,
    @required this.students,
  });

  factory RepeatingByRange.fromMap(Map<String, dynamic> map) =>
      RepeatingByRange(
        range: map['category'],
        students: int.parse(map['alumnos'].toString()),
      );

  String range;
  int students;
}
