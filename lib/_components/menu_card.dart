import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    @required this.title,
    this.route,
    this.imagePath,
    this.image,
    this.isPrimary = true,
    this.widgetRoute,
    Key key,
  }) : super(key: key);

  final String route;
  final String title;
  final String imagePath;
  final bool isPrimary;
  final Image image;
  final Widget widgetRoute;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => route != null
            ? Navigator.pushNamed(
                context,
                route,
              )
            : Navigator.push(context,
                MaterialPageRoute<Widget>(builder: (_) => widgetRoute)),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor[40], width: 2.5),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Card(
            margin: EdgeInsets.zero,
            color: isPrimary ? cardColorPrimary : cardColorSecondary,
            elevation: cardElevation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                image ??
                    Image.asset(
                      imagePath,
                      width: 64,
                      height: 64,
                    ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: body1().copyWith(
                    color: primaryColor[80],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
