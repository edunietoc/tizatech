import 'package:flutter/cupertino.dart';

class PersonalImprovement {
  PersonalImprovement({
    this.pIList,
  });
  factory PersonalImprovement.fromMap(Map<String, dynamic> map) {
    List<dynamic> indicatorList =
        List<dynamic>.from(map['lista_tipo_indicador']);

    return PersonalImprovement(
      pIList: List<PersonalImprovementIndicator>.from(map['lista_indicadores']
          ?.map((_) => PersonalImprovementIndicator.fromMap(_, indicatorList))),
    );
  }

  List<PersonalImprovementIndicator> pIList;
}

class PersonalImprovementIndicator {
  PersonalImprovementIndicator({
    this.course,
    this.values,
  });
  factory PersonalImprovementIndicator.fromMap(
      Map<String, dynamic> map, List<String> indicators) {
    List<PIValues> _values = indicators
        .map((String indicator) => PIValues.fromMap(map, indicator))
        .toList();
    return PersonalImprovementIndicator(
      course: map['curso'],
      values: _values,
    );
  }

  final String course;
  List<PIValues> values;
}

class PIValues {
  PIValues({
    @required this.name,
    @required this.value,
  });

  factory PIValues.fromMap(Map<String, dynamic> map, String indicator) =>
      PIValues(
        name: indicator,
        value: map[indicator],
      );

  String name;
  double value;
}
