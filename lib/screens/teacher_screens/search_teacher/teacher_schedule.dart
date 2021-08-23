import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/avatar_info.dart';
import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/user.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';

class TeacherScheduleScreen extends StatelessWidget {
  const TeacherScheduleScreen({
    @required this.teacher,
    Key key,
  }) : super(key: key);
  final Teacher teacher;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(
              title: 'teacherScreens.searchTeacher.teacher'.tr(),
            ),
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              AvatarInfo(
                user: teacher,
                showId: true,
                profileImage:
                    locator<UserService>().getUserAvatar(userParam: teacher),
              ),
              _TeacherHours(teacher: teacher)
            ]))
          ],
        ),
      );
}

class _TeacherHours extends StatelessWidget {
  const _TeacherHours({
    @required this.teacher,
    Key key,
  }) : super(key: key);

  final Teacher teacher;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'teacherScreens.searchTeacher.hoursTitle'.tr(),
              style: h4(context).copyWith(
                color: secondaryColor[80],
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'teacherScreens.searchTeacher.roomHours'.tr(),
                  style: body1(context).copyWith(color: blackShadesColor[70]),
                ),
                TextSpan(text: '${teacher.roomHours}', style: body1(context))
              ]),
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'teacherScreens.searchTeacher.schoolHours'.tr(),
                  style: body1(context).copyWith(color: blackShadesColor[70]),
                ),
                TextSpan(text: '${teacher.schoolHours}', style: body1(context))
              ]),
            ),
          ],
        ),
      );
}
