import 'package:flutter/material.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/option_tile.dart';
import '../../../models/courses.dart';
import '../../../models/user.dart';
import '../../home/home.dart';

class TeacherStudentListScreen extends StatelessWidget {
  const TeacherStudentListScreen({
    @required this.course,
    Key key,
  }) : super(key: key);

  final Courses course;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(
              title: '${course.name} ${course.letter}',
              subtitle: course.schedule,
            ),
            SliverPadding(padding: const EdgeInsets.only(top: 32)),
            SliverList(
                delegate: SliverChildListDelegate(course.studentList
                    .map(
                      (Student student) => OptionTile(
                        text: student.fullName,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<Widget>(
                              builder: (_) => HomeScreen(
                                userParam: student,
                              ),
                            )),
                      ),
                    )
                    .toList()))
          ],
        ),
      );
}
