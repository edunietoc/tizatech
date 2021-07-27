import 'package:flutter/material.dart';

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

TextStyle h1(BuildContext context) => Theme.of(context).textTheme.headline1;
TextStyle h2(BuildContext context) => Theme.of(context).textTheme.headline2;
TextStyle h3(BuildContext context) => Theme.of(context).textTheme.headline3;

TextStyle h4(BuildContext context) => Theme.of(context).textTheme.headline4;
TextStyle body1(BuildContext context) => Theme.of(context).textTheme.bodyText1;
TextStyle body2(BuildContext context) => Theme.of(context).textTheme.bodyText2;
TextStyle caption(BuildContext context) => Theme.of(context).textTheme.caption;

const double cardElevation = 6;

Map<int, String> monthConstants = <int, String>{
  1: 'Enero',
  2: 'Febrero',
  3: 'Marzo',
  4: 'Abril',
  5: 'Mayo',
  6: 'Junio',
  7: 'Julio',
  8: 'Agosto',
  9: 'Septiembre',
  10: 'Octubre',
  11: 'Noviembre',
  12: 'Diciembre',
};
