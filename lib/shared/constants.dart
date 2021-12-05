import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'colors.dart';

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

TextStyle h1() => const TextStyle(
    fontSize: 44, fontWeight: FontWeight.w500, color: blackShadesColor);
TextStyle h2() => const TextStyle(
    fontSize: 36, fontWeight: FontWeight.w500, color: blackShadesColor);
TextStyle h3() => const TextStyle(fontSize: 32, color: blackShadesColor);

TextStyle h4() => const TextStyle(fontSize: 24, color: blackShadesColor);
TextStyle body1() => const TextStyle(fontSize: 18, color: blackShadesColor);
TextStyle body2() => const TextStyle(fontSize: 16, color: blackShadesColor);
TextStyle caption() => const TextStyle(fontSize: 14, color: blackShadesColor);

const double cardElevation = 6;

String january = 'months.january'.tr();
String february = 'months.february'.tr();
String march = 'months.march'.tr();
String april = 'months.april'.tr();
String may = 'months.may'.tr();
String june = 'months.june'.tr();
String july = 'months.july'.tr();
String august = 'months.august'.tr();
String september = 'months.september'.tr();
String october = 'months.october'.tr();
String november = 'months.november'.tr();
String december = 'months.december'.tr();

Map<int, String> monthConstants = <int, String>{
  1: january,
  2: february,
  3: march,
  4: april,
  5: may,
  6: june,
  7: july,
  8: august,
  9: september,
  10: october,
  11: november,
  12: december,
};

Map<String, int> monthConstantsNumber = <String, int>{
  january: 1,
  february: 2,
  march: 3,
  april: 4,
  may: 5,
  june: 6,
  july: 7,
  august: 8,
  september: 9,
  october: 10,
  november: 11,
  december: 12,
};

class FileContentType {
  MediaType mediaType(String extension) {
    Map<String, MediaType> map = {};
  }
}
