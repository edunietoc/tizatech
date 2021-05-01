import 'package:flutter/material.dart';

import '_components/loader.dart';
import 'locator/locator.dart';
import 'screens/auth/login.dart';
import 'screens/home/home.dart';
import 'screens/notifications/notifications.dart';
import 'screens/profile/profile.dart';
import 'screens/student_list/student_list.dart';
import 'screens/student_screen/attendments/attendments.dart';
import 'screens/student_screen/books/books_screen.dart';
import 'screens/student_screen/delayments/delayments.dart';
import 'screens/student_screen/grades/grades.dart';
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
        title: 'Tizatech',
        navigatorKey: locator<NavigationService>().navigatorKey,
        routes: <String, WidgetFun>{
          Routes.loader: (BuildContext context) => Loader(),
          Routes.home: (BuildContext context) => HomeScreen(),
          Routes.profile: (BuildContext context) => ProfileScreen(),
          Routes.books: (BuildContext context) => BooksScreen(),
          Routes.grades: (BuildContext context) => GradesScreen(),
          Routes.assistance: (BuildContext context) => AttendmentsScreen(),
          Routes.delayments: (BuildContext context) => DelaymentScreen(),
          Routes.notifications: (BuildContext context) => NotificationsScreen(),
          Routes.login: (BuildContext context) => LoginScreen(),
          Routes.studentList: (BuildContext context) => StudentListScreen(),
        },
        theme: ThemeData(
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
