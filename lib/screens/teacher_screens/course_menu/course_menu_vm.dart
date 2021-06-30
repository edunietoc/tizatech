import 'package:tizatech/screens/teacher_screens/grades/subject_selection.dart';
import 'package:tizatech/screens/teacher_screens/grades/grades.dart';
import 'package:tizatech/screens/teacher_screens/subject_list/subject_list.dart';

import '../../../_components/menu_card.dart';
import '../../../models/courses.dart';
import '../student_list/student_list.dart';

class TeacherCourseMenuViewModel {
  TeacherCourseMenuViewModel(Courses course) {
    _currentCourse = course;

    menuItems = <MenuCard>[
      MenuCard(
        title: 'Alumnos',
        imagePath: 'assets/images/home/message_dot.png',
        widgetRoute: TeacherStudentListScreen(
          course: _currentCourse,
        ),
      ),
      MenuCard(
        title: 'Asignaturas',
        imagePath: 'assets/images/home/message_dot.png',
        widgetRoute: SubjectListScreen(currentCourse: _currentCourse),
      ),
      MenuCard(
        title: 'Lecturas Anuales',
        imagePath: 'assets/images/home/books.png',
      ),
      MenuCard(
        title: 'Notas',
        imagePath: 'assets/images/home/courses.png',
        widgetRoute: SubjectSelectionScreen(course: _currentCourse),
      ),
    ];
  }

  Courses _currentCourse;

  List<MenuCard> menuItems;
}
