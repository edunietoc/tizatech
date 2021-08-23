import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/option_tile.dart';
import '../../../models/user.dart';
import 'teacher_schedule.dart';

class TeacherListScreen extends StatelessWidget {
  const TeacherListScreen({
    @required this.teacherList,
    Key key,
  }) : super(key: key);
  final List<Teacher> teacherList;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(
              title: 'teacherScreens.searchTeacher.teacher'.tr(),
            ),
            SliverPadding(padding: const EdgeInsets.only(top: 32)),
            SliverList(
                delegate: SliverChildListDelegate(teacherList
                    .map((Teacher teacher) => OptionTile(
                        text: teacher.halfName,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<Widget>(
                              builder: (_) =>
                                  TeacherScheduleScreen(teacher: teacher),
                            ))))
                    .toList())),
          ],
        ),
      );
}
