class AttendanceBase {
  AttendanceBase({
    this.anualList,
    this.mensualList,
    this.todayList,
    this.levelList,
  });

  factory AttendanceBase.fromMap(Map<String, dynamic> map) {
    List<String> constantLevelList =
        List<String>.from(map['lista_niveles_anual']);
    List<String> constantCoursesList =
        List<String>.from(map['lista_cursos_unica']);

    return AttendanceBase(
      anualList: List<AttendanceAnualMonth>.from(
          map['lista_anual']?.map((_) => AttendanceAnualMonth.fromMap(_))),
      mensualList: constantCoursesList
          .map((String course) => AttendanceMonthDay.fromMap(
              (map['lista_mensual'] as List<dynamic>).singleWhere(
                (dynamic element) =>
                    (element as Map<String, dynamic>).containsKey(course),
              ),
              course))
          .toList(),
      todayList: constantCoursesList
          .map((String course) => AttendanceMonthDay.fromMap(
                (map['lista_diario'] as List<dynamic>).singleWhere(
                  (dynamic element) =>
                      (element as Map<String, dynamic>).containsKey(course),
                ),
                course,
                isMonth: false,
              ))
          .toList(),
      levelList: constantLevelList
          .map((String levelName) => AttendanceMonthDay.fromMap(
              (map['lista_niveles'] as List<dynamic>).singleWhere(
                (dynamic element) =>
                    (element as Map<String, dynamic>).containsKey(levelName),
              ),
              levelName))
          .toList(),
    );
  }
  List<AttendanceAnualMonth> anualList;
  List<AttendanceMonthDay> mensualList;
  List<AttendanceMonthDay> todayList;
  List<AttendanceMonthDay> levelList;
}

class AttendanceAnualMonth {
  AttendanceAnualMonth({
    this.month,
    this.value,
  });

  factory AttendanceAnualMonth.fromMap(Map<String, dynamic> map) =>
      AttendanceAnualMonth(
        month: map['mes'],
        value: map['total'],
      );

  String month;
  String value;
}

class AttendanceMonthDay {
  AttendanceMonthDay({
    this.courseName,
    this.date,
    this.value,
  });

  factory AttendanceMonthDay.fromMap(
    Map<String, dynamic> map,
    String courseName, {
    bool isMonth = true,
  }) =>
      AttendanceMonthDay(
        courseName: courseName,
        value: map[courseName],
        date: isMonth ? map['mes'] : map['dia'],
      );

  String courseName;
  String date;
  String value;
}
