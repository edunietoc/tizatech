import 'package:flutter/material.dart';

import '_components/loader.dart';
import 'locator/locator.dart';
import 'screens/attendments/attendments.dart';
import 'screens/auth/login.dart';
import 'screens/books/books_screen.dart';
import 'screens/delayments/delayments.dart';
import 'screens/grades/grades.dart';
import 'screens/home/home.dart';
import 'screens/profile/profile.dart';
import 'services/navigation.dart';
import 'shared/colors.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

typedef WidgetFun = Widget Function(BuildContext context);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: locator<NavigationService>().navigatorKey,
        routes: <String, WidgetFun>{
          Routes.loader: (BuildContext context) => Loader(),
          Routes.home: (BuildContext context) => HomeScreen(),
          Routes.profile: (BuildContext context) => ProfileScreen(),
          Routes.books: (BuildContext context) => BooksScreen(),
          Routes.grades: (BuildContext context) => GradesScreen(),
          Routes.assistance: (BuildContext context) => AttendmentsScreen(),
          Routes.delayments: (BuildContext context) => DelaymentScreen(),
        },
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            brightness: Brightness.light,
            fixTextFieldOutlineLabel: false,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w500,
                  color: blackShadesColor),
              headline2: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: blackShadesColor),
              headline3: TextStyle(fontSize: 32, color: blackShadesColor),
              headline4: TextStyle(fontSize: 24, color: blackShadesColor),
              bodyText1: TextStyle(fontSize: 18, color: blackShadesColor),
              bodyText2: TextStyle(fontSize: 16, color: blackShadesColor),
              caption: TextStyle(fontSize: 14, color: blackShadesColor),
            ),
            colorScheme: colorScheme,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: blackShadesColor[05],
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 20, color: secondaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            )),
        home: LoginScreen(),
      );
}
