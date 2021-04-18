import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo({
    @required this.firstName,
    @required this.lastName,
    @required this.profileImage,
    this.middleName = '',
    this.lastName2 = '',
    this.description,
    this.id = '',
    this.showId = false,
    Key key,
  }) : super(key: key);
  final String firstName;
  final String middleName;
  final String lastName;
  final String lastName2;
  final String description;
  final String id;
  final bool showId;
  final Image profileImage;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 16,
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: profileImage,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (!showId)
                          ? '$firstName $middleName \n$lastName $lastName2'
                          : '$firstName $lastName ',
                      style: h4(context),
                      maxLines: 2,
                    ),
                    if (showId && id.isNotEmpty) Text(id)
                  ],
                )
              ],
            ),
            if (description != null)
              Container(
                padding: EdgeInsets.only(top: 16, left: 24, right: 24),
                width: deviceWidth(context),
                child: Text(
                  description,
                  textAlign: TextAlign.left,
                  style: body1(context).copyWith(
                    color: blackShadesColor[70],
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
          ],
        ),
      );
}
