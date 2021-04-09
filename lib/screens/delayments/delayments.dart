import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';

class DelaymentScreen extends StatelessWidget {
  const DelaymentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(title: 'Retrasos', subtitle: 'Alumno'),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    width: deviceWidth(context),
                    height: deviceHeight(context) * 0.5,
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
