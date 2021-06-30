import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/app_bar.dart';
import 'package:tizatech/_components/grades_table.dart';
import 'package:tizatech/_components/loader.dart';
import 'package:tizatech/models/courses.dart';
import 'package:tizatech/models/grades_subject.dart';
import 'package:tizatech/screens/teacher_screens/grades/grades_vm.dart';
import 'package:tizatech/shared/colors.dart';
import 'package:tizatech/shared/constants.dart';

class TeacherGradesScreen extends StatelessWidget {
  const TeacherGradesScreen({
    @required this.subject,
    Key key,
  }) : super(key: key);
  final TeacherSubject subject;

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
                      title: 'Notas',
                      subtitle: subject.name.toLowerCase(),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(
                      [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 24,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                              color: blackShadesColor[30],
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <_DataContainer>[
                                  _DataContainer(
                                    data: 'Alumnos',
                                    flex: 3,
                                  ),
                                  _DataContainer(
                                    data: 'Evaluacion',
                                    flex: 2,
                                  )
                                ],
                              ),
                              Container(
                                height: deviceHeight(context) * 0.6,
                                width: deviceWidth(context),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: viewModel.grades.length,
                                  itemBuilder: (_, int index) => Row(
                                    children: <Widget>[
                                      _DataContainer(
                                        data: viewModel
                                            .grades[index].student.halfName,
                                        isColoured: index.isEven,
                                        isAlignedLeft: true,
                                        flex: 3,
                                      ),
                                      _DataContainer(
                                        data: viewModel.grades[index].grade
                                            .toStringAsFixed(1),
                                        isColoured: index.isEven,
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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

class _DataContainer extends StatelessWidget {
  const _DataContainer({
    @required this.data,
    this.isColoured = false,
    this.isAlignedLeft = false,
    this.flex = 1,
    Key key,
  }) : super(key: key);

  final String data;
  final bool isColoured;
  final bool isAlignedLeft;
  final int flex;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: flex,
        child: Container(
          height: 40,
          color: isColoured ? blackShadesColor[05] : Colors.white,
          alignment: isAlignedLeft ? Alignment.centerLeft : Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(data),
        ),
      );
}
