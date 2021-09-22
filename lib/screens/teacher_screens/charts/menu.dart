import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/option_tile.dart';
import 'annotations/annotations.dart';
import 'attendance/attendance.dart';
import 'attendance/attendance_vm.dart';
import 'enrollment/enrollment.dart';
import 'internships/internships.dart';
import 'personal_improvement/personal_improvement.dart';
import 'ptu/ptu.dart';
import 'repeating/repeating.dart';
import 'simce_essay/simce_essay.dart';
import 'simce_essay/simce_essay_vm.dart';

class ChartListScreen extends StatelessWidget {
  const ChartListScreen({Key key}) : super(key: key);
// comment
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(
              title: 'teacherScreens.charts.menu.title'.tr(),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(height: 32),
                OptionTile(
                  text: 'teacherScreens.charts.menu.attendments'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) =>
                          AttendanceChartScreen(AttendanceType.attendance),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.unattendments'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) =>
                          AttendanceChartScreen(AttendanceType.unattendance),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.delayments'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) =>
                          AttendanceChartScreen(AttendanceType.delayment),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.simceEssay'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => SimceScoreChartScreen(SimceType.essay),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.simceScore'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => SimceScoreChartScreen(SimceType.score),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.enrollment'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => EnrollmentChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.annotations'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => AnnotationsChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.repeating'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => RepeatingChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.ptu'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => PTUChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.internship'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => InternshipChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'teacherScreens.charts.menu.improvement'.tr(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => PersonalImpChartScreen(),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      );
}
