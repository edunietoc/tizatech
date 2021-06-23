class Enrollment {
  Enrollment({
    this.anualList,
    this.genderList,
    this.courseList,
    this.levelList,
  });

  factory Enrollment.fromMap(Map<String, dynamic> map) => Enrollment(
        anualList: List<AnualEnrollment>.from(
            map['lista_anual']?.map((_) => AnualEnrollment.fromMap(_))),
        genderList: List<GenderEnrollment>.from(
            map['lista_genero']?.map((_) => GenderEnrollment.fromMap(_))),
        courseList: List<CategoryEnrollment>.from(
            map['lista_curso']?.map((_) => CategoryEnrollment.fromMap(_))),
        levelList: List<CategoryEnrollment>.from(
            map['lista_nivel']?.map((_) => CategoryEnrollment.fromMap(_))),
      );

  List<AnualEnrollment> anualList;
  List<GenderEnrollment> genderList;
  List<CategoryEnrollment> courseList;
  List<CategoryEnrollment> levelList;
}

class AnualEnrollment {
  AnualEnrollment({
    this.year,
    this.total,
  });

  factory AnualEnrollment.fromMap(Map<String, dynamic> map) => AnualEnrollment(
        year: map['year'],
        total: map['total'],
      );

  String year;
  String total;
}

class GenderEnrollment {
  GenderEnrollment({
    this.gender,
    this.total,
  });

  factory GenderEnrollment.fromMap(Map<String, dynamic> map) =>
      GenderEnrollment(
        gender: map['genero'],
        total: map['total'],
      );

  String gender;
  String total;
}

class CategoryEnrollment {
  CategoryEnrollment({
    this.category,
    this.value,
  });

  factory CategoryEnrollment.fromMap(Map<String, dynamic> map) =>
      CategoryEnrollment(
        category: map['category'],
        value: map['value'],
      );

  String category;
  String value;
}
