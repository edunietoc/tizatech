import 'package:flutter/material.dart';
import 'package:tizatech/_components/menu_card.dart';
import 'package:tizatech/services/navigation.dart';
import 'package:tizatech/shared/colors.dart';
import 'package:tizatech/shared/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            forceElevated: true,
            backgroundColor: secondaryColor,
            /*   title: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/logo/white.png',
                height: 30,
              ),
            ), */
            leading: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Image.asset(
                'assets/logo/white.png',
                height: 30,
              ),
            ),
            leadingWidth: deviceWidth(context) / 2,
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
                    children: [
                      Text(
                        'Rosa Linda Vasquez Hernandez',
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
          SliverPadding(padding: EdgeInsets.only(top: 10)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              children: [
                MenuCard(
                  title: 'Perfil',
                  imagePath: 'assets/images/home/profile.png',
                  route: Routes.loader,
                ),
                MenuCard(
                  title: 'Notas',
                  imagePath: 'assets/images/home/grades.png',
                  route: Routes.profile,
                ),
                MenuCard(
                  title: 'Lecturas Anuales',
                  imagePath: 'assets/images/home/books.png',
                  route: Routes.loader,
                ),
                MenuCard(
                  title: 'Mensajes',
                  imagePath: 'assets/images/home/messages.png',
                  route: Routes.profile,
                ),
                MenuCard(
                  title: 'Asistencias',
                  imagePath: 'assets/images/home/attendments.png',
                  route: Routes.loader,
                ),
                MenuCard(
                  title: 'Atrasos',
                  imagePath: 'assets/images/home/delayments.png',
                  route: Routes.profile,
                ),
                MenuCard(
                  title: 'Notificaciones',
                  imagePath: 'assets/images/home/notifications.png',
                  route: Routes.loader,
                ),
              ],
            ),
          )
          /* GridView.count(
            crossAxisCount: 2,
            children: [
              MenuCard(
                title: 'Loader',
                route: Routes.loader,
              ),
              MenuCard(
                title: 'Perfil',
                route: Routes.profile,
              ),
            ],
          ), */
        ],
      ),
    );
  }
}
