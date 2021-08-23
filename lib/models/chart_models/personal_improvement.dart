import 'package:flutter/cupertino.dart';

class PersonalImprovement {
  PersonalImprovement({
    this.pIList,
    this.indicatorList,
  });
  factory PersonalImprovement.fromMap(Map<String, dynamic> map) {
    List<String> indicatorList = (map['lista_tipo_indicador'] as List<dynamic>)
        .map((_) => _.toString())
        .toList();

    return PersonalImprovement(
      pIList: List<PersonalImprovementIndicator>.from(map['lista_indicadores']
          ?.map((_) => PersonalImprovementIndicator.fromMap(_, indicatorList))),
      indicatorList: indicatorList,
    );
  }

  List<PersonalImprovementIndicator> pIList;
  List<String> indicatorList;
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
        value: double.tryParse(map[indicator].toString()),
      );

  String name;
  double value;
}
