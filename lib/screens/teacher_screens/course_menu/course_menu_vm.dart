import 'package:tizatech/screens/teacher_screens/take_attendment/verify_code.dart';

import '../../../_components/menu_card.dart';
import '../../../models/courses.dart';
import '../grades/subject_selection.dart';
import '../student_list/student_list.dart';
import '../subject_list/subject_list.dart';

class TeacherCourseMenuViewModel {
  TeacherCourseMenuViewModel(Courses course) {
    _currentCourse = course;

    menuItems = <MenuCard>[
      MenuCard(
        title: 'Alumnos',
        imagePath: 'assets/images/home/students.png',
        widgetRoute: TeacherStudentListScreen(
          course: _currentCourse,
        ),
      ),
      MenuCard(
        title: 'Asignaturas',
        imagePath: 'assets/images/home/books.png',
        widgetRoute: SubjectListScreen(currentCourse: _currentCourse),
      ),
      /* MenuCard(
        title: 'Lecturas Anuales',
        imagePath: 'assets/images/home/books.png',
      ), */
      MenuCard(
        title: 'Notas',
        imagePath: 'assets/images/home/grades.png',
        widgetRoute: SubjectSelectionScreen(course: _currentCourse),
      ),
      MenuCard(
        title: 'Asistencia',
        imagePath: 'assets/images/home/attendments.png',
        widgetRoute: TeacherVerifyCodeScreen(course: _currentCourse),
      ),
    ];
  }

  Courses _currentCourse;

  List<MenuCard> menuItems;
}
