import '../../_components/menu_card.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../services/navigation.dart';
import '../student_screen/attendments/attendments.dart';
import '../student_screen/books/books_screen.dart';
import '../student_screen/delayments/delayments.dart';
import '../student_screen/grades/grades.dart';

import 'package:easy_localization/easy_localization.dart';

class HomeViewModel {
  HomeViewModel({User userParameter}) {
    user = userParameter ?? locator<UserService>().user;
    userParam = userParameter;
    studentMenu = <MenuCard>[
      MenuCard(
        title: 'menu.profile'.tr(),
        image: locator<UserService>().getUserAvatar(),
        route: Routes.profile,
      ),
      MenuCard(
        title: 'menu.grades'.tr(),
        imagePath: 'assets/images/home/grades.png',
        route: Routes.grades,
      ),
      MenuCard(
        title: 'menu.attendments'.tr(),
        imagePath: 'assets/images/home/attendments.png',
        route: Routes.assistance,
      ),
      MenuCard(
        title: 'menu.delayments'.tr(),
        imagePath: 'assets/images/home/delayments.png',
        route: Routes.delayments,
      ),
      MenuCard(
        title: 'menu.books'.tr(),
        imagePath: 'assets/images/home/books.png',
        route: Routes.books,
      ),
    ];

    reducedStudentMenu = <MenuCard>[
      MenuCard(
        title: 'menu.grades'.tr(),
        imagePath: 'assets/images/home/grades.png',
        widgetRoute: GradesScreen(userParam: user),
      ),
      MenuCard(
        title: 'menu.attendments'.tr(),
        imagePath: 'assets/images/home/attendments.png',
        widgetRoute: AttendmentsScreen(userParam: user),
      ),
      MenuCard(
        title: 'menu.delayments'.tr(),
        imagePath: 'assets/images/home/delayments.png',
        widgetRoute: DelaymentScreen(userParam: user),
      ),
      MenuCard(
        title: 'menu.books'.tr(),
        imagePath: 'assets/images/home/books.png',
        widgetRoute: BooksScreen(userParam: user),
      ),
    ];

    parentMenu = <MenuCard>[
      MenuCard(
        title: 'menu.profile'.tr(),
        image: locator<UserService>().getUserAvatar(),
        route: Routes.profile,
      ),
      MenuCard(
        title: 'menu.students'.tr(),
        imagePath: 'assets/images/home/students.png',
        route: Routes.studentList,
      ),
      MenuCard(
        title: 'menu.messages'.tr(),
        imagePath: 'assets/images/home/message_dot.png',
        route: Routes.messages,
      ),
    ];

    teacherMenu = <MenuCard>[
      MenuCard(
        title: 'menu.profile'.tr(),
        image: locator<UserService>().getUserAvatar(),
        route: Routes.profile,
      ),
      MenuCard(
        title: 'menu.messages'.tr(),
        imagePath: 'assets/images/home/messages.png',
        route: Routes.messages,
      ),
      /* MenuCard(
        title: 'Lecturas Anuales',
        imagePath: 'assets/images/home/books.png',
        route: Routes.books,
      ), */
      MenuCard(
        title: 'menu.digitalBook'.tr(),
        imagePath: 'assets/images/home/courses.png',
        route: Routes.courses,
      ),
      MenuCard(
        title: 'menu.charts'.tr(),
        imagePath: 'assets/images/home/charts.png',
        route: Routes.charts,
      ),
      MenuCard(
        title: 'menu.teachers'.tr(),
        imagePath: 'assets/images/home/teachers.png',
        route: Routes.searchTeacher,
      ),
    ];
  }

  User user;
  User userParam;

  List<MenuCard> get currentList {
    UserType userType = locator<UserService>().getUserType;

    if (userType == UserType.student) {
      return studentMenu;
    } else if (userType == UserType.parent) {
      if (user.id == locator<UserService>().user.id) {
        return parentMenu;
      } else {
        return reducedStudentMenu;
      }
    } else if (userType == UserType.teacher) {
      if (userParam != null && userParam is Student) {
        return reducedStudentMenu;
      } else {
        return teacherMenu;
      }
    }
  }

  List<MenuCard> studentMenu;

  List<MenuCard> reducedStudentMenu;

  List<MenuCard> parentMenu;

  List<MenuCard> teacherMenu;

  List<MenuCard> coursesTeacherMenu;
}
