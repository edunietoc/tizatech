class SimceScore {
  SimceScore({
    this.languageScore,
    this.mathScore,
    this.historyScore,
    this.scienceScore,
  });

  factory SimceScore.fromMap(Map<String, dynamic> map) => SimceScore(
        languageScore: List<SimceSubject>.from(
            map['lista_lenguaje']?.map((_) => SimceSubject.fromMap(_))),
        mathScore: List<SimceSubject>.from(
            map['lista_matematicas']?.map((_) => SimceSubject.fromMap(_))),
        historyScore: List<SimceSubject>.from(
            map['lista_historia']?.map((_) => SimceSubject.fromMap(_))),
        scienceScore: List<SimceSubject>.from(
            map['lista_ciencias']?.map((_) => SimceSubject.fromMap(_))),
      );

  List<SimceSubject> languageScore;
  List<SimceSubject> mathScore;
  List<SimceSubject> historyScore;
  List<SimceSubject> scienceScore;
}

class SimceSubject {
  SimceSubject({
    this.score,
    this.date,
  });
  factory SimceSubject.fromMap(Map<String, dynamic> map) => SimceSubject(
        score: map['puntaje'],
        date: map['date'],
      );

  String score;
  String date;
}
