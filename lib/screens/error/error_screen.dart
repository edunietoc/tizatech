import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    @required this.errorDescription,
    @required this.errorImage,
    @required this.errorTitle,
    @required this.screenTitle,
    @required this.user,
    this.screenSubtitle,
    Key key,
  }) : super(key: key);

  final String screenTitle;
  final String screenSubtitle;
  final String errorTitle;
  final String errorDescription;
  final String errorImage;
  final User user;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          TizaAppBar(title: screenTitle, subtitle: screenSubtitle),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            Column(
              children: <Widget>[
                AvatarInfo(
                  user: user,
                  showId: true,
                  profileImage: locator<UserService>().getUserAvatar(),
                ),
                SizedBox(height: 55),
                Image.asset(errorImage),
                SizedBox(height: 24),
                Text(
                  errorTitle,
                  style: h3(context).copyWith(color: blackShadesColor[80]),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text(
                    errorDescription,
                    style: body1(context).copyWith(
                      color: blackShadesColor[70],
                      letterSpacing: 0.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ]))
        ]),
      );
}
