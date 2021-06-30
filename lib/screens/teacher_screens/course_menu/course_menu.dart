import 'package:flutter/material.dart';
import 'package:tizatech/_components/app_bar.dart';
import 'package:tizatech/models/courses.dart';
import 'package:tizatech/screens/teacher_screens/course_menu/course_menu_vm.dart';

class TeacherCourseMenuScreen extends StatelessWidget {
  const TeacherCourseMenuScreen({
    @required this.course,
    Key key,
  }) : super(key: key);
  final Courses course;

  @override
  Widget build(BuildContext context) {
    TeacherCourseMenuViewModel viewModel = TeacherCourseMenuViewModel(course);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TizaAppBar(title: '${course.name} ${course.letter}', subtitle: ''),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              children: viewModel.menuItems,
            ),
          ),
        ],
      ),
    );
  }
}
