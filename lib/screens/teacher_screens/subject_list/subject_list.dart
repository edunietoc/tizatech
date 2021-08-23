import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/avatar_info.dart';
import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/courses.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({
    @required this.currentCourse,
    Key key,
  }) : super(key: key);

  final Courses currentCourse;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(
              title: 'teacherScreens.subjectList.title'.tr(),
              subtitle: currentCourse.courseName,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  AvatarInfo(
                    user: locator<UserService>().user,
                    profileImage: locator<UserService>().getUserAvatar(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Text(
                      'teacherScreens.subjectList.description'.tr(),
                      style: body1(context).copyWith(
                        color: blackShadesColor[70],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List<Widget>.generate(
                        currentCourse.subjectList.length,
                        (int index) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: Text(
                            currentCourse.subjectList[index].name.trimLeft(),
                            style: body1(context),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
