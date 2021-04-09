import 'package:flutter/material.dart';

const MaterialColor primaryColor = MaterialColor(0xFF49C4B8, <int, Color>{
  40: Color(0xFF93E2DA),
  60: Color(0xFF49C4B8),
  80: Color(0xFF2C766E),
});

const MaterialColor secondaryColor = MaterialColor(0xFFFFC905, <int, Color>{
  40: Color(0xFFFFE99B),
  60: Color(0xFFFFC905),
  80: Color(0xFF8C6623),
});

const Color neutralColor = Color(0xFF071412);

const Color successColor = Color(0xFF0FBB29);

const Color errorColor = Color(0xFFD91809);

const Color warningColor = Color(0xFFECF013);

const Color informationColor = Color(0xFF083FDF);

const Color disabledColor = Color(0xFF04615E);

const Color backgroundColor = Color(0xFFFCFCFC);

const Color cardColorPrimary = Color(0xFFF7FCFB);

const Color cardColorSecondary = Color(0xFFFFFAE6);

const Color attendmentsChartColor = Color(0xFF42B0A6);

const Color delaymentsChartColor = Color(0xFFF06C79);

const MaterialColor blackShadesColor = MaterialColor(0xFF071412, <int, Color>{
  100: Color(0xFF071412),
  90: Color(0xFF202B2A),
  80: Color(0xFF394341),
  70: Color(0xFF515859),
  30: Color(0xFF9B9E9D),
  20: Color(0xFFCDD0D0),
  10: Color(0xFFE6E8E7),
  05: Color(0xFFF6F6F6),
});

ColorScheme colorScheme = ColorScheme(
  primary: primaryColor[60],
  primaryVariant: primaryColor[80],
  secondary: secondaryColor[60],
  secondaryVariant: secondaryColor[80],
  surface: cardColorPrimary,
  background: backgroundColor,
  error: errorColor,
  onPrimary: blackShadesColor[100],
  onSecondary: blackShadesColor[100],
  onSurface: blackShadesColor[90],
  onBackground: blackShadesColor[90],
  onError: blackShadesColor[05],
  brightness: Brightness.light,
);
