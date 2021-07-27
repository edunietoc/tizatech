import 'dart:convert';

import 'package:flutter/cupertino.dart';

class PTU {
  PTU({
    this.languageList,
    this.mathList,
    this.scienceList,
    this.mandatoryList,
    this.menList,
    this.rankingList,
  });

  factory PTU.fromMap(Map<String, dynamic> map) => PTU(
        languageList: List<PTUData>.from(
            map['lista_lenguaje']?.map((_) => PTUData.fromMap(_))),
        mathList: List<PTUData>.from(
            map['lista_matematica']?.map((_) => PTUData.fromMap(_))),
        scienceList: List<PTUData>.from(
            map['lista_ciencias']?.map((_) => PTUData.fromMap(_))),
        mandatoryList: List<PTUData>.from(
            map['lista_obligatorias']?.map((_) => PTUData.fromMap(_))),
        menList: List<PTUData>.from(
            map['lista_MEN']?.map((_) => PTUData.fromMap(_))),
        rankingList: List<PTUData>.from(
            map['lista_ranking']?.map((_) => PTUData.fromMap(_))),
      );

  factory PTU.fromJson(String source) => PTU.fromMap(json.decode(source));
  List<PTUData> languageList;

  List<PTUData> mathList;

  List<PTUData> scienceList;

  List<PTUData> mandatoryList;

  List<PTUData> menList;

  List<PTUData> rankingList;
}

class PTUData {
  PTUData({
    @required this.scoreLabel,
    @required this.students,
  });

  factory PTUData.fromMap(Map<String, dynamic> map) => PTUData(
        scoreLabel: map['puntaje'],
        students: map['alumnos'],
      );

  factory PTUData.fromJson(String source) =>
      PTUData.fromMap(json.decode(source));

  final String scoreLabel;
  final int students;
}
