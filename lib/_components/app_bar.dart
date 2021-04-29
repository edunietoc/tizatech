import 'package:flutter/material.dart';

import '../shared/colors.dart';

class TizaAppBar extends StatelessWidget {
  const TizaAppBar({
    @required this.title,
    @required this.subtitle,
    this.hasExit = false,
    this.hasLogo = false,
    this.isHome = false,
    Key key,
  }) : super(key: key);

  final bool hasLogo;
  final bool hasExit;
  final String title;
  final String subtitle;
  final bool isHome;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        floating: true,
        forceElevated: true,
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        title: hasLogo
            ? Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Image.asset(
                  'assets/logo/white.png',
                  height: 30,
                  width: 60,
                ),
              )
            : Container(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: secondaryColor[80],
                  ),
                  label: Text(
                    'Regresar',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: secondaryColor[80]),
                  ),
                ),
              ),
        actions: <Widget>[
          if (hasExit)
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
              Size.fromHeight(MediaQuery.of(context).size.height / 7),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Text>[
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: isHome
                      ? Theme.of(context).textTheme.headline3
                      : Theme.of(context).textTheme.headline1,
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.left,
                  style: isHome
                      ? Theme.of(context).textTheme.bodyText1.copyWith(
                            color: primaryColor[80],
                          )
                      : Theme.of(context).textTheme.headline4.copyWith(
                            color: primaryColor[80],
                          ),
                ),
              ],
            ),
          ),
        ),
      );
}
