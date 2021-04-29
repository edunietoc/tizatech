import 'package:flutter/material.dart';

import '../models/user.dart';
import '../shared/colors.dart';
import '../shared/constants.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo({
    @required this.user,
    this.description,
    this.showId = false,
    this.profileImage,
    Key key,
  }) : super(key: key);
  final User user;
  final String description;

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
                          ? '${user.firstName} ${user.middleName} \n${user.lastName} ${user.lastName2}'
                          : '${user.firstName} ${user.lastName} ',
                      style: body1(context),
                      maxLines: 2,
                    ),
                    if (showId && user.rut.isNotEmpty) Text(user.rut)
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
