import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../_components/loader.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'grades_table.dart';
import 'grades_vm.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({Key key}) : super(key: key);

  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  ScrollController horizontalGradesController;
  @override
  void initState() {
    horizontalGradesController = ScrollController();

    super.initState();
  }

  final User user = locator<UserService>().user;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<GradesViewModel>(
        create: (_) => GradesViewModel()..getStudentGrades(),
        builder: (BuildContext context, _) => Consumer<GradesViewModel>(
            builder: (BuildContext context, GradesViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.error:
              return Text(viewModel.error);

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
                            user: user,
                            profileImage: Image.network(
                              user.picturePath,
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
