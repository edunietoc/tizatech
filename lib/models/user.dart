import 'dart:convert';

enum Gender {
  masculino,
  femenino,
}

class User {
  User({
    this.id,
    this.userType,
    this.firstName,
    this.middleName,
    this.lastName,
    this.lastName2,
    this.rut,
    this.nationality,
    this.street,
    this.location,
    this.email,
    this.mobilePhone,
    this.homePhone,
    this.parent,
    this.birthDate,
    this.picturePath,
    this.gender,
    this.studentList,
    this.grade,
    this.gradeLetter,
    this.schoolId,
    this.verifierDigit,
  });

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromMap(Map<String, dynamic> map) => User(
      id: int.tryParse(map['id'].toString()),
      firstName: map['first_name'],
      middleName: map['middle_name'],
      lastName: map['last_name'],
      lastName2: map['second_last_name'],
      rut: map['rut'],
      nationality: map['nationality'],
      street: map['calle'],
      location: map['comuna'],
      email: map['email'],
      mobilePhone: map['mobile_phone'],
      homePhone: map['home_phone'],
      picturePath: map['picture'],
      birthDate: map['birth_date'],
      gender: map['gender'] == 'Femenino' ? Gender.femenino : Gender.masculino,
      grade: map['grade'],
      gradeLetter: map['letra_curso'],
      verifierDigit: map['verifier_digit']);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token,
        'id': id,
        'userType': userType,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'lastName2': lastName2,
        'rut': rut,
        'nationality': nationality,
        'street': street,
        'location': location,
        'email': email,
        'mobilePhone': mobilePhone,
        'homePhone': homePhone,
        'birth_date': birthDate,
        'parent': parent.toMap(),
      };

  String toJson() => json.encode(toMap());

  String token;
  int id;
  int userType;
  String firstName;
  String middleName;
  String lastName;
  String lastName2;
  String rut;
  String nationality;
  String street;
  String location;
  String email;
  String mobilePhone;
  String homePhone;
  Parent parent;
  String picturePath;
  String birthDate;
  Gender gender;
  String grade;
  String gradeLetter;
  List<Student> studentList;
  int schoolId;
  String verifierDigit;
  String get fullName => '$firstName $middleName $lastName $lastName2';
  String get halfName => '$firstName $lastName';
}

class Parent extends User {
  Parent({
    int id,
    String firstName,
    String middleName,
    String lastName,
    String lastName2,
    String rut,
    String nationality,
    String street,
    String location,
    String email,
    String mobilePhone,
    String homePhone,
    String picturePath,
    String birthDate,
    Gender gender,
    List<Student> studentList,
    int schoolId,
    int userType,
  }) : super(
          id: id,
          email: email,
          middleName: middleName,
          firstName: firstName,
          lastName2: lastName2,
          lastName: lastName,
          rut: rut,
          nationality: nationality,
          street: street,
          location: location,
          mobilePhone: mobilePhone,
          homePhone: homePhone,
          picturePath: picturePath,
          gender: gender,
          studentList: studentList,
          birthDate: birthDate,
          schoolId: schoolId,
          userType: userType,
        );

  factory Parent.fromMap(Map<String, dynamic> map) {
    List<dynamic> responseStudentList = map['alumno_set'];

    List<Student> studentList = responseStudentList
        .map((dynamic student) => Student.fromMap(student))
        .toList();

    return Parent(
      id: int.tryParse(map['id'].toString()),
      firstName: map['first_name'],
      middleName: map['middle_name'],
      lastName: map['last_name'],
      lastName2: map['second_last_name'],
      rut: map['rut'],
      nationality: map['nationality'],
      street: map['calle'],
      location: map['comuna'],
      email: map['email'],
      mobilePhone: map['mobile_phone'],
      homePhone: map['home_phone'],
      birthDate: map['birth_date'],
      picturePath: map['picture'],
      studentList: studentList,
      gender: map['gender'] == 'Femenino' ? Gender.femenino : Gender.masculino,
      schoolId: map['establecimiento']['id'],
      userType: 2,
    );
  }
}

class Student extends User {
  Student({
    int id,
    String firstName,
    String middleName,
    String lastName,
    String lastName2,
    String rut,
    String nationality,
    String street,
    String location,
    String email,
    String mobilePhone,
    String homePhone,
    String picturePath,
    Gender gender,
    String birthDate,
    String grade,
    String gradeLetter,
    int userType,
    int schoolId,
  }) : super(
          id: id,
          email: email,
          middleName: middleName,
          firstName: firstName,
          lastName2: lastName2,
          lastName: lastName,
          rut: rut,
          nationality: nationality,
          street: street,
          location: location,
          mobilePhone: mobilePhone,
          homePhone: homePhone,
          picturePath: picturePath,
          gender: gender,
          birthDate: birthDate,
          grade: grade,
          gradeLetter: gradeLetter,
          userType: userType,
          schoolId: schoolId,
        );

  factory Student.fromMap(Map<String, dynamic> map) => Student(
        id: map['id'],
        firstName: map['first_name'],
        middleName: map['middle_name'],
        lastName: map['last_name'],
        lastName2: map['second_last_name'],
        rut: map['rut'],
        nationality: map['nationality'],
        street: map['calle'],
        location: map['comuna'],
        email: map['email'],
        mobilePhone: map['mobile_phone'],
        homePhone: map['home_phone'],
        picturePath: map['picture'],
        birthDate: map['birth_date'],
        gender:
            map['gender'] == 'Femenino' ? Gender.femenino : Gender.masculino,
        grade: map['grade'],
        gradeLetter: map['letra_curso'],
        userType: 1,
      );
}

class Teacher extends User {
  Teacher({
    int id,
    String firstName,
    String middleName,
    String lastName,
    String lastName2,
    String rut,
    String nationality,
    String street,
    String location,
    String email,
    String mobilePhone,
    String homePhone,
    String picturePath,
    String birthDate,
    Gender gender,
    List<Student> studentList,
    int schoolId,
    String verifierDigit,
    this.roomHours,
    this.schoolHours,
  }) : super(
          id: id,
          email: email,
          middleName: middleName,
          firstName: firstName,
          lastName2: lastName2,
          lastName: lastName,
          rut: rut,
          nationality: nationality,
          street: street,
          location: location,
          mobilePhone: mobilePhone,
          homePhone: homePhone,
          picturePath: picturePath,
          gender: gender,
          studentList: studentList,
          birthDate: birthDate,
          schoolId: schoolId,
          verifierDigit: verifierDigit,
          userType: 3,
        );

  factory Teacher.fromMap(Map<String, dynamic> map) => Teacher(
      id: map['id'],
      firstName: map['first_name'],
      middleName: map['middle_name'],
      lastName: map['last_name'],
      lastName2: map['second_last_name'],
      rut: map['rut'],
      nationality: map['nationality'],
      street: map['calle'],
      location: map['comuna'],
      email: map['email'],
      mobilePhone: map['mobile_phone'],
      homePhone: map['home_phone'],
      birthDate: map['birth_date'],
      picturePath: map['picture'],
      gender: map['gender'] == 'Femenino' ? Gender.femenino : Gender.masculino,
      schoolId: map['establecimiento']['id'],
      verifierDigit: map['verifier_digit'],
      roomHours: map['horas_aula'],
      schoolHours: map['horas_colegio']);

  int schoolHours;
  int roomHours;
}
