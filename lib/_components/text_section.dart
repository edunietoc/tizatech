import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';

class MenuText extends StatelessWidget {
  const MenuText({
    @required this.title,
    @required this.list,
    Key key,
  }) : super(key: key);
  final String title;
  final List<TextSection> list;
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Container(
            width: deviceWidth(context),
            padding: EdgeInsets.only(left: 24, bottom: 8, top: 32),
            child: Text(
              title,
              style: h4(context).copyWith(color: secondaryColor[80]),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: deviceWidth(context),
            child: GridView.count(
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              shrinkWrap: true,
              childAspectRatio: 5 / 1,
              padding: EdgeInsets.zero,
              children: list,
            ),
          ),
        ],
      );
}

class TextSection extends StatelessWidget {
  const TextSection({
    @required this.title,
    @required this.value,
    Key key,
  }) : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: caption(context).copyWith(color: blackShadesColor[70]),
            ),
            SizedBox(height: 4),
            Flexible(
              child: Text(
                value,
                style: body2(context),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
