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
  });

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromMap(Map<String, dynamic> map) => User(
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
      );

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
  List<Student> studentList;
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
            birthDate: birthDate);

  factory Parent.fromMap(Map<String, dynamic> map) {
    List<dynamic> responseStudentList = map['alumno_set'];

    List studentList = responseStudentList
        .map((dynamic student) => Student.fromMap(student))
        .toList();

    print(studentList);
    return Parent(
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
      );
}
