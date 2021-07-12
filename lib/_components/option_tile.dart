import 'package:flutter/material.dart';

import '../shared/colors.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    @required this.text,
    @required this.onTap,
    this.padding,
    Key key,
  }) : super(key: key);

  final String text;
  final Function onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? EdgeInsets.only(left: 24, right: 24, bottom: 16),
        child: ListTile(
          title: Text(
            text,
          ),
          tileColor: blackShadesColor[05],
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: primaryColor[80],
          ),
          onTap: onTap,
        ),
      );
}
