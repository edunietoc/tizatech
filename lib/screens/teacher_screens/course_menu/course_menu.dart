import 'package:flutter/material.dart';

import '../../../_components/app_bar.dart';
import '../../../models/courses.dart';
import 'course_menu_vm.dart';

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
        slivers: <Widget>[
          TizaAppBar(
            title: '${course.name} ${course.letter}',
            subtitle: course.schedule,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
