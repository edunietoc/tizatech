import 'package:flutter/material.dart';
import 'package:tizatech/shared/constants.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../_components/text_section.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = locator<UserService>().user;
    print('student List ${user.studentList}');
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          TizaAppBar(title: 'Perfil', subtitle: 'Alumno'),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                AvatarInfo(
                  user: user,
                  profileImage: locator<UserService>().getUserAvatar,
                ),
                MenuText(
                  title: 'General',
                  list: <TextSection>[
                    TextSection(
                      title: 'Fecha de Nacimiento',
                      value: user.birthDate,
                    ),
                    TextSection(
                      title: 'Nacionalidad',
                      value: user.nationality,
                    ),
                    TextSection(
                      title: 'Cedula',
                      value: user.rut,
                    ),
                    TextSection(
                      title: 'Calle',
                      value: user.street,
                    ),
                    TextSection(
                      title: 'Comuna',
                      value: user.location,
                    )
                  ],
                ),
                MenuText(
                  title: 'Contacto',
                  list: <TextSection>[
                    TextSection(
                      title: 'Correo Electronico',
                      value: user.email,
                    ),
                    TextSection(
                      title: 'Telefono (movil)',
                      value: user.mobilePhone,
                    ),
                    TextSection(
                      title: 'Telefono (casa)',
                      value: user.homePhone,
                    ),
                  ],
                ),
                if (locator<UserService>().getUserType == UserType.parent)
                  Column(
                    children: List<Widget>.generate(
                      user.studentList.length,
                      (int index) => Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          user.studentList[index].fullName,
                          style: body2(context),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
