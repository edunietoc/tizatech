import 'package:flutter/material.dart';
import 'package:tizatech/screens/teacher_screens/charts/annotations/annotations.dart';
import 'package:tizatech/screens/teacher_screens/charts/enrollment/enrollment.dart';
import 'package:tizatech/screens/teacher_screens/charts/simce_essay/simce_essay.dart';

import '../../../_components/app_bar.dart';
import 'attendance/attendance.dart';

class ChartListScreen extends StatelessWidget {
  const ChartListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            TizaAppBar(title: 'Graficas', subtitle: ''),
            SliverList(
                delegate: SliverChildListDelegate([
              ListTile(
                title: Text('Asistencias'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (_) => AttendanceChartScreen(),
                  ),
                ),
              ),
              ListTile(
                title: Text('Ensayo Simce'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (_) => SimceScoreChartScreen(),
                  ),
                ),
              ),
              ListTile(
                title: Text('Matricula'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (_) => EnrollmentChartScreen(),
                  ),
                ),
              ),
              ListTile(
                title: Text('Cumplimiento'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (_) => AnnotationsChartScreen(),
                  ),
                ),
              ),
            ]))

            /* ListView(
              children: [
              
              ],
            ) */
          ],
        ),
      );
}
