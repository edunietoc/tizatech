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
