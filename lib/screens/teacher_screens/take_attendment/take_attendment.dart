import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/loader.dart';
import '../../../_components/table.dart';
import '../../../models/courses.dart';
import '../../../models/user.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
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
                        title: 'teacherScreens.takeAttendment.title'.tr(),
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
                                    text: 'teacherScreens.takeAttendment.turn'
                                        .tr(),
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
                              firstColumnLabel:
                                  'teacherScreens.takeAttendment.students'.tr(),
                              secondCoulmnLabel:
                                  'teacherScreens.takeAttendment.attendment'
                                      .tr(),
                              thirdColumnLabel:
                                  'teacherScreens.takeAttendment.delayment'
                                      .tr(),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 24),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: ElevatedButton(
                                onPressed: () => viewModel.uploadAttendments(),
                                child: Text(
                                    'teacherScreens.takeAttendment.save'.tr()),
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
