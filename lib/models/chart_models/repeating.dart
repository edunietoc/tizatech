import 'package:flutter/cupertino.dart';

class RepeatingStudents {
  RepeatingStudents({
    this.anualList,
    this.levelList,
  });

  factory RepeatingStudents.fromMap(Map<String, dynamic> map) =>
      RepeatingStudents(
        anualList: List<RepeatingByYear>.from(
            map['lista_repitientes']?.map((_) => RepeatingByYear.fromMap(_))),
        levelList: List<RepeatingByLevel>.from(map['lista_repitientes_nivel']
            ?.map((_) => RepeatingByLevel.fromMap(_))),
      );

  List<RepeatingByYear> anualList;
  List<RepeatingByLevel> levelList;
}

class RepeatingByYear {
  RepeatingByYear({
    this.date,
    this.approved,
    this.reproved,
  });

  factory RepeatingByYear.fromMap(Map<String, dynamic> map) => RepeatingByYear(
        date: map['date'],
        approved: map['aprobacion'],
        reproved: map['reprobacion'],
      );

  String date;
  double approved;
  double reproved;
}

class RepeatingByLevel {
  RepeatingByLevel({
    this.levels,
  });

  factory RepeatingByLevel.fromMap(Map<String, dynamic> map) =>
      RepeatingByLevel(
        levels: List<LevelRepeating>.from(map['lista_repitientes_nivel']
            ?.map((_) => LevelRepeating.fromMap(_))),
      );

  List<LevelRepeating> levels;
}

class LevelRepeating {
  LevelRepeating({
    @required this.level,
    @required this.approved,
    @required this.reproved,
  });

  factory LevelRepeating.fromMap(Map<String, dynamic> map) => LevelRepeating(
        level: map['category'],
        approved: map['aprobacion'],
        reproved: map['reprobacion'],
      );
  String level;
  double approved;
  double reproved;
}
