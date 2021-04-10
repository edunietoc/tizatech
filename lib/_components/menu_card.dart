import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    @required this.title,
    @required this.route,
    @required this.imagePath,
    this.isPrimary = true,
    Key key,
  }) : super(key: key);

  final String route;
  final String title;
  final String imagePath;
  final bool isPrimary;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.pushNamed(context, route),
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
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: primaryColor[80],
                      ),
                ),
              ],
            ),
          ),
        ),
      );
}
