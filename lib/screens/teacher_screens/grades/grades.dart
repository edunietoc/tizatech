import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/loader.dart';
import '../../../_components/table.dart';
import '../../../models/courses.dart';
import '../../../models/grades_subject.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
import 'grades_vm.dart';

class TeacherGradesScreen extends StatelessWidget {
  const TeacherGradesScreen({
    @required this.subject,
    this.courseName,
    Key key,
  }) : super(key: key);
  final TeacherSubject subject;
  final String courseName;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<TeacherGradesViewModel>(
        create: (_) => TeacherGradesViewModel(subject),
        child: Scaffold(
          body: Consumer<TeacherGradesViewModel>(
              builder: (_, TeacherGradesViewModel viewModel, __) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('Error');

              case Status.done:
                return CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: courseName,
                      subtitle: subject.name.toLowerCase().trimLeft(),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(
                      <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 32, left: 24),
                          child: Text(
                            'Notas',
                            style: h3(context).copyWith(
                              color: secondaryColor[80],
                            ),
                          ),
                        ),
                        TizaTable(
                          firstColumnLabel: 'Alumnos',
                          secondCoulmnLabel: 'Nota',
                          dataRows: viewModel.grades
                              .map((GradesByStudent grades) => TizaDataRow(
                                    label: grades.student.halfName,
                                    value: grades.grade.toStringAsFixed(1),
                                  ))
                              .toList(),
                        ),
                      ],
                    ))
                  ],
                );
              default:
                return Container();
            }
          }),
        ),
      );
}
