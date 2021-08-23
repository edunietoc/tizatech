import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/option_tile.dart';
import '../../../models/courses.dart';
import 'grades.dart';

class SubjectSelectionScreen extends StatelessWidget {
  const SubjectSelectionScreen({
    @required this.course,
    Key key,
  }) : super(key: key);

  final Courses course;

  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          TizaAppBar(
              title: 'teacherScreens.grades.title'.tr(), subtitle: course.name),
          SliverPadding(padding: const EdgeInsets.only(top: 32)),
          SliverList(
            delegate: SliverChildListDelegate(course.subjectList
                .map((TeacherSubject subject) => OptionTile(
                      text: subject.name,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (_) => TeacherGradesScreen(
                                subject: subject,
                                courseName: course.courseName),
                          )),
                    ))
                .toList()),
          )
        ],
      ));
}
