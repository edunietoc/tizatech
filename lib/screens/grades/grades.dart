import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/subject.dart';
import '../../models/user.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'grades_table.dart';

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
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(title: 'Notas', subtitle: 'Alumno'),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  AvatarInfo(
                    firstName: user.firstName,
                    middleName: user.middleName,
                    lastName2: user.lastName2,
                    lastName: user.lastName,
                    profileImage: Image.network(
                      user.picturePath,
                    ),
                    description:
                        'Desliza a la izquierda para visualizar\nlas notas de cada asignatura.',
                  ),
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
                              text: '3.45',
                              style: h4(context)
                                  .copyWith(color: blackShadesColor)),
                        ],
                      ),
                    ),
                  ),
                  GradesTable(
                    subjectList: List<Subject>.generate(
                      10,
                      (int index) => Subject(
                        name: 'Matematica',
                        grades: <double>[12, 541, 84, 984, 15, 21, 18, 21],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
