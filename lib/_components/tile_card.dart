import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';

class TileCard extends StatelessWidget {
  const TileCard({
    @required this.title,
    @required this.description,
    @required this.iconPath,
    @required this.onTap,
    this.isBlue = false,
    this.author,
    Key key,
  }) : super(key: key);
  final String title;
  final String description;
  final String author;
  final String iconPath;
  final Function onTap;
  final bool isBlue;

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
        elevation: cardElevation,
        color: isBlue ? cardColorPrimary : cardColorSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          side: BorderSide(
            width: 1.5,
            color: isBlue ? primaryColor[80] : secondaryColor[80],
          ),
        ),
        child: ListTile(
          title: Text(title, style: body1()),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Text>[
              Text(description,
                  style: body2().copyWith(
                      color: isBlue ? primaryColor[80] : secondaryColor[80])),
              if (author != null)
                Text(author,
                    style: caption().copyWith(color: blackShadesColor[70]))
            ],
          ),
          leading: Image.asset(iconPath),
          horizontalTitleGap: 10,
          contentPadding: EdgeInsets.all(16),
          onTap: onTap,
        ),
      );
}
