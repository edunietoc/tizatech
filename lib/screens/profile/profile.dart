import 'package:flutter/material.dart';

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

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          TizaAppBar(title: 'Perfil', subtitle: 'Alumno'),
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
                if (locator<UserService>().getUserType == UserType.student)
                  MenuText(
                    title: 'Apoderado',
                    list: <TextSection>[
                      TextSection(
                        title: 'Nombre',
                        value: user.parent.fullName,
                      ),
                      TextSection(
                        title: 'Telefono (Casa)',
                        value: user.parent.homePhone,
                      ),
                      TextSection(
                        title: 'Telefono (movil)',
                        value: user.parent.mobilePhone,
                      )
                    ],
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
