import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../services/navigation.dart';
import '../../shared/colors.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    this.userParam,
    Key key,
  }) : super(key: key);

  final User userParam;

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = HomeViewModel(userParameter: userParam);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          if (userParam != null)
            TizaAppBar(
                title: userParam.halfName,
                subtitle:
                    locator<UserService>().userTypeString(userParam: userParam))
          else
            HomeAppBar(user: viewModel.user),
          SliverPadding(padding: EdgeInsets.only(top: 32)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              children: viewModel.currentList,
            ),
          ),
          SliverPadding(padding: EdgeInsets.all(24)),
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    @required this.user,
    Key key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        floating: true,
        forceElevated: true,
        backgroundColor: secondaryColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(
            'assets/logo/white.png',
            height: 50,
            width: 100,
          ),
        ),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, Routes.login),
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
              Size.fromHeight(MediaQuery.of(context).size.height / 5),
          child: Padding(
            padding: const EdgeInsets.all(020),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${user.fullName}',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    locator<UserService>().userTypeString(),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: primaryColor[80],
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
