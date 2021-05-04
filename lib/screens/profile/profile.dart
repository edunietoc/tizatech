import 'package:flutter/material.dart';
import 'package:tizatech/shared/colors.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../_components/text_section.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../shared/constants.dart';
import '../home/home.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    this.userParam,
    Key key,
  }) : super(key: key);
  final User userParam;
  @override
  Widget build(BuildContext context) {
    User user = userParam ?? locator<UserService>().user;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          TizaAppBar(
              title: 'Perfil',
              subtitle:
                  locator<UserService>().userTypeString(userParam: userParam)),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                AvatarInfo(
                  user: user,
                  profileImage: locator<UserService>().getUserAvatar(),
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
                if (locator<UserService>().getUserType == UserType.parent &&
                    userParam == null)
                  Container(
                    padding: EdgeInsets.only(left: 24, bottom: 8, top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: deviceWidth(context),
                          child: Text(
                            'Apoderado',
                            style:
                                h4(context).copyWith(color: secondaryColor[80]),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            'Estudiantes a su cargo',
                            style: caption(context)
                                .copyWith(color: blackShadesColor[70]),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                      ],
                    ),
                  ),
                if (userParam != null)
                  Container(
                    padding: EdgeInsets.all(24),
                    child: ElevatedButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                builder: (_) => HomeScreen(
                                  userParam: user,
                                ),
                              ),
                            ),
                        child: Text('Informacion Academica')),
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
