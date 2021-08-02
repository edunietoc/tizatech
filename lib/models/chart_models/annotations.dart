class Annotations {
  Annotations({
    this.anualAnnotations,
    this.monthlyAnnotations,
    this.levelAnnotations,
    this.courseAnnotations,
  });

  factory Annotations.fromMap(Map<String, dynamic> map) {
    List<dynamic> constantAnnotations =
        (map['lista_tipo_faltas'] as List<dynamic>)
            .map((dynamic element) => element[0])
            .toList();

    return Annotations(
      anualAnnotations: List<AnualAnnotation>.from(
          map['lista_anotacion']?.map((_) => AnualAnnotation.fromMap(_))),
      monthlyAnnotations: List<MonthAnnotation>.generate(
          (map['dict_faltas_curso'] as Map<String, dynamic>).length,
          (int index) => MonthAnnotation.fromList(
              map['dict_faltas_curso']['${index + 1}'])),
      levelAnnotations: List<LevelAnnotation>.from(map['lista_anotacion_nivel']
          ?.map((_) => LevelAnnotation.fromMap(_, constantAnnotations))),
      courseAnnotations: List<CourseAnnotation>.from(
          map['lista_anotacion_faltas']
              ?.map((_) => CourseAnnotation.fromMap(_))),
    );
  }
  List<AnualAnnotation> anualAnnotations;
  List<MonthAnnotation> monthlyAnnotations;
  List<LevelAnnotation> levelAnnotations;
  List<CourseAnnotation> courseAnnotations;
}

class AnualAnnotation {
  AnualAnnotation({
    this.type,
    this.total,
  });

  factory AnualAnnotation.fromMap(Map<String, dynamic> map) => AnualAnnotation(
        type: _mapNames[map['name']],
        total: map['total'],
      );

  static const Map<String, String> _mapNames = <String, String>{
    'Falta muy leve': 'Falta\n muy leve',
    'Falta leve': 'Falta\n leve',
    'Falta grave': 'Falta\n grave',
    'Falta gravisima': 'Falta\n gravisima',
    'Positiva': 'Positiva',
  };

  String type;
  String total;
}

class MonthAnnotation {
  MonthAnnotation({
    this.values,
  });
  factory MonthAnnotation.fromList(List<dynamic> list) =>
      MonthAnnotation(values: list.map((_) => CourseValue.fromMap(_)).toList());

  List<CourseValue> values;
}

class CourseValue {
  CourseValue({
    this.course,
    this.total,
  });

  factory CourseValue.fromMap(Map<String, dynamic> map) => CourseValue(
        course: map['curso'],
        total: map['total'],
      );
  String course;
  String total;
}

class LevelAnnotation {
  LevelAnnotation({
    this.name,
    this.categories,
  });

  factory LevelAnnotation.fromMap(
          Map<String, dynamic> map, List<dynamic> categories) =>
      LevelAnnotation(
        name: map['name'],
        categories: categories
            .map((dynamic name) =>
                CategoryLevelAnnotation.fromValues(name.toString(), map[name]))
            .toList(),
      );

  String name;
  List<CategoryLevelAnnotation> categories;
}

class CategoryLevelAnnotation {
  CategoryLevelAnnotation({
    this.name,
    this.value,
  });

  factory CategoryLevelAnnotation.fromValues(String name, String value) =>
      CategoryLevelAnnotation(
        name: _mapNames[name],
        value: value,
      );
  static const Map<String, String> _mapNames = <String, String>{
    'total_falta_muy_leve': 'Falta\n muy leve',
    'total_falta_leve': 'Falta\n leve',
    'total_falta_grave': 'Falta\n grave',
    'total_falta_gravisima': 'Falta\n gravisima',
    'total_positiva': 'Positiva',
  };

  String name;
  String value;
}

class CourseAnnotation {
  CourseAnnotation({
    this.category,
    this.value,
  });

  factory CourseAnnotation.fromMap(Map<String, dynamic> map) =>
      CourseAnnotation(
        category: map['category'],
        value: map['value'],
      );

  String category;
  String value;
}
