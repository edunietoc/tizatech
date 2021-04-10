import 'package:flutter/material.dart';

import '../../_components/menu_card.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../services/navigation.dart';
import '../../shared/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = locator<UserService>().user;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            forceElevated: true,
            backgroundColor: secondaryColor,
            title: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Image.asset(
                'assets/logo/white.png',
                height: 50,
                width: 100,
              ),
            ),
            actions: <Widget>[
              TextButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/exit.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Salir',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: secondaryColor[80],
                      ),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height / 8),
              child: Padding(
                padding: const EdgeInsets.all(020),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${user.fullName}',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        'Alumno',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: primaryColor[80],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 32)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              children: <MenuCard>[
                MenuCard(
                  title: 'Perfil',
                  imagePath: 'assets/images/home/profile.png',
                  route: Routes.profile,
                ),
                MenuCard(
                  title: 'Notas',
                  imagePath: 'assets/images/home/grades.png',
                  route: Routes.grades,
                ),
                MenuCard(
                  title: 'Lecturas Anuales',
                  imagePath: 'assets/images/home/books.png',
                  route: Routes.books,
                ),
                MenuCard(
                  title: 'Mensajes',
                  imagePath: 'assets/images/home/messages.png',
                  route: Routes.profile,
                ),
                MenuCard(
                  title: 'Asistencias',
                  imagePath: 'assets/images/home/attendments.png',
                  route: Routes.assistance,
                ),
                MenuCard(
                  title: 'Atrasos',
                  imagePath: 'assets/images/home/delayments.png',
                  route: Routes.delayments,
                ),
                MenuCard(
                  title: 'Notificaciones',
                  imagePath: 'assets/images/home/notifications.png',
                  route: Routes.loader,
                ),
              ],
            ),
          ),
          SliverPadding(padding: EdgeInsets.all(24)),
        ],
      ),
    );
  }
}
