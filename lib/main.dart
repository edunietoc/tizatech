import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '_components/loader.dart';
import 'locator/locator.dart';
import 'screens/auth/login.dart';
import 'screens/home/home.dart';
import 'screens/messages/message_screen.dart';
import 'screens/notifications/notifications.dart';
import 'screens/profile/profile.dart';
import 'screens/student_list/student_list.dart';
import 'screens/student_screen/attendments/attendments.dart';
import 'screens/student_screen/books/books_screen.dart';
import 'screens/student_screen/delayments/delayments.dart';
import 'screens/student_screen/grades/grades.dart';
import 'screens/teacher_screens/charts/menu.dart';
import 'screens/teacher_screens/courses/courses.dart';
import 'screens/teacher_screens/search_teacher/search_teacher.dart';
import 'services/navigation.dart';
import 'shared/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  runApp(EasyLocalization(
    supportedLocales: <Locale>[
      Locale('es', ''),
      Locale('en', ''),
    ],
    path: 'assets/translations', // <-- change the path of the translation files
    fallbackLocale: Locale('es', ''),
    child: MyApp(),
  ));
}

typedef WidgetFun = Widget Function(BuildContext context);

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  Future<void> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } on Exception catch (_) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    return MaterialApp(
      title: 'Tizatech',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
        Routes.courses: (BuildContext context) => CoursesScreen(),
        Routes.messages: (BuildContext context) => MessagesScreen(),
        Routes.charts: (_) => ChartListScreen(),
        Routes.searchTeacher: (_) => SearchTeacherScreen(),
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
            labelStyle: TextStyle(color: primaryColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: primaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: secondaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
          )),
      home: LoginScreen(),
    );
  }
}
