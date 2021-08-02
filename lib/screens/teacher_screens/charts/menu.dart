import 'package:flutter/material.dart';
import 'package:tizatech/screens/teacher_screens/charts/attendance/attendance_vm.dart';
import 'package:tizatech/screens/teacher_screens/charts/internships/internships.dart';
import 'package:tizatech/screens/teacher_screens/charts/personal_improvement/personal_improvement.dart';
import 'package:tizatech/screens/teacher_screens/charts/ptu/ptu.dart';
import 'package:tizatech/screens/teacher_screens/charts/repeating/repeating.dart';
import 'package:tizatech/screens/teacher_screens/charts/simce_essay/simce_essay_vm.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/option_tile.dart';
import 'annotations/annotations.dart';
import 'attendance/attendance.dart';
import 'enrollment/enrollment.dart';
import 'simce_essay/simce_essay.dart';

class ChartListScreen extends StatelessWidget {
  const ChartListScreen({Key key}) : super(key: key);
// comment
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(
              title: 'Informe de Gestión',
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(height: 32),
                OptionTile(
                  text: 'Asistencias',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) =>
                          AttendanceChartScreen(AttendanceType.attendance),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Inasistencias',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) =>
                          AttendanceChartScreen(AttendanceType.unattendance),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Retrasos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) =>
                          AttendanceChartScreen(AttendanceType.delayment),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Ensayo Simce',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => SimceScoreChartScreen(SimceType.essay),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Puntaje Simce',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => SimceScoreChartScreen(SimceType.score),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Matricula',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => EnrollmentChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Cumplimiento',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => AnnotationsChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Repitiencia',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => RepeatingChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'PTU',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => PTUChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Practicas',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => InternshipChartScreen(),
                    ),
                  ),
                ),
                OptionTile(
                  text: 'Desarrollo Personal',
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
