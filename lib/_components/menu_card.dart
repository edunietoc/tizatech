import 'package:flutter/material.dart';
import 'package:tizatech/shared/colors.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    @required this.title,
    @required this.route,
    @required this.imagePath,
    Key key,
  }) : super(key: key);

  final String route;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor[40], width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 6,
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
}
