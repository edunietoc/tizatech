import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/avatar_info.dart';
import '../../../_components/loader.dart';
import '../../../models/user.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
import '../../error/error_screen.dart';
import 'grades_table.dart';
import 'grades_vm.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({this.userParam, Key key}) : super(key: key);

  @override
  final User userParam;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<GradesViewModel>(
        create: (_) =>
            GradesViewModel(userParam: userParam)..getStudentGrades(),
        builder: (BuildContext context, _) => Consumer<GradesViewModel>(
            builder: (BuildContext context, GradesViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.error:
              return ErrorScreen(
                errorDescription: viewModel.errorDescription,
                errorImage: viewModel.errorImage,
                errorTitle: viewModel.errorTitle,
                screenSubtitle: 'Alumno',
                screenTitle: 'Notas',
                user: viewModel.user,
              );

            case Status.loading:
              return Loader();

            case Status.done:
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(title: 'Notas', subtitle: 'Alumno'),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          AvatarInfo(
                            user: viewModel.user,
                            profileImage: Image.network(
                              viewModel.user.picturePath,
                            ),
                            description:
                                'Desliza a la izquierda para visualizar\nlas notas de cada asignatura.',
                          ),
                          if (viewModel.gradeAverage != null)
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Promedio General: ',
                                  style: h4(context).copyWith(
                                    color: secondaryColor[80],
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: viewModel.gradeAverage
                                            .toStringAsFixed(1),
                                        style: h4(context)
                                            .copyWith(color: blackShadesColor)),
                                  ],
                                ),
                              ),
                            ),
                          if (viewModel.subjectList != null)
                            GradesTable(subjectList: viewModel.subjectList),
                        ],
                      ),
                    ),
                  ],
                ),
              );
          }
        }),
      );
}
