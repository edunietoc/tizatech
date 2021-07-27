import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/loader.dart';
import 'package:tizatech/shared/constants.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/table.dart';
import '../../../models/courses.dart';
import '../../../models/user.dart';
import '../../../shared/colors.dart';
import 'take_attendment_vm.dart';

class TeacherTakeAttendmentScreen extends StatelessWidget {
  const TeacherTakeAttendmentScreen({
    @required this.course,
    @required this.code,
    Key key,
  }) : super(key: key);

  final Courses course;
  final String code;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider<TakeAttendmentViewModel>(
            create: (_) => TakeAttendmentViewModel(
                  code: code,
                  course: course,
                ),
            child: Consumer<TakeAttendmentViewModel>(
                builder: (_, TakeAttendmentViewModel viewModel, __) {
              switch (viewModel.currentStatus) {
                case Status.error:
                  return Text('Errror');

                case Status.loading:
                  return Loader();

                case Status.done:
                  return CustomScrollView(
                    slivers: <Widget>[
                      TizaAppBar(
                        title: 'Asistencias',
                        subtitle: course.courseName,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 32,
                                left: 24,
                                right: 24,
                              ),
                              child: RichText(
                                  text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Turno: ',
                                    style: body1(context).copyWith(
                                      color: blackShadesColor[70],
                                    ),
                                  ),
                                  TextSpan(
                                    text: course.schedule,
                                    style: body1(context),
                                  )
                                ],
                              )),
                            ),
                            TizaTable(
                              dataRows: course.studentList
                                  .map(
                                    (Student student) => TizaDataRow(
                                      label: student.halfName,
                                      value: Checkbox(
                                        activeColor: primaryColor[80],
                                        value: !viewModel
                                            .isMarkedAsUnnatendance(student),
                                        onChanged: (_) =>
                                            viewModel.addItem(student),
                                      ),
                                      thirdValue: Checkbox(
                                        activeColor: primaryColor[80],
                                        value:
                                            !viewModel.isMarkedAsLate(student),
                                        onChanged: (_) => viewModel.addItem(
                                            student,
                                            modifyLateStudents: true),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              firstColumnLabel: 'Alumnos',
                              secondCoulmnLabel: 'Asistencia',
                              thirdColumnLabel: 'Retraso',
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 24),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: ElevatedButton(
                                onPressed: () => viewModel.uploadAttendments(),
                                child: Text('Guardar'),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );

                default:
                  return Container();
              }
            })),
      );
}
