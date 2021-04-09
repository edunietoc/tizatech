import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../locator/locator.dart';
import '../services/navigation.dart';
import '../shared/colors.dart';
import '../shared/constants.dart';

class Loader extends StatelessWidget {
  const Loader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: secondaryColor,
        body: Center(
          child: SpinKitDoubleBounce(
            size: 100,
            itemBuilder: (BuildContext context, int index) => DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index.isEven ? primaryColor : blackShadesColor[05],
              ),
            ),
          ),
        ),
      );
}

void showLoader() {
  BuildContext context = locator<NavigationService>().currentContext;
  showDialog(
    context: context,
    useSafeArea: false,
    builder: (BuildContext context) => Container(
      width: deviceWidth(context),
      height: deviceHeight(context),
      color: secondaryColor,
      child: Loader(),
    ),
  );
}

void closeLoader() {
  BuildContext context = locator<NavigationService>().currentContext;
  Navigator.pop(context);
}
