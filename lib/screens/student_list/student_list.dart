import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../_components/tile_card.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import '../profile/profile.dart';

class StudentListScreen extends StatelessWidget {
  StudentListScreen({Key key}) : super(key: key);

  final User user = locator<UserService>().user;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(title: 'Estudiantes', subtitle: 'Apoderado'),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  AvatarInfo(
                    user: user,
                    profileImage: locator<UserService>().getUserAvatar(),
                    description:
                        'Visualiza todos los estudiantes registrados a tu nombre.',
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 24,
                      top: 24,
                      bottom: 20,
                    ),
                    child: Text(
                      'Lista de Estudiantes',
                      style: h3().copyWith(
                        color: primaryColor[80],
                      ),
                    ),
                  ),
                  Column(
                    children: List<TileCard>.generate(
                      user.studentList.length,
                      (int index) => TileCard(
                        title: user.studentList[index].halfName,
                        description:
                            '${user.studentList[index].grade} - ${user.studentList[index].gradeLetter}',
                        isBlue: true,
                        iconPath: 'assets/images/avatars/boy.png',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (_) => ProfileScreen(
                              userParam: user.studentList[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
