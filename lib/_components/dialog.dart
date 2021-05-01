import 'package:flutter/material.dart';
import 'package:tizatech/shared/colors.dart';
import 'package:tizatech/shared/constants.dart';

void showMessageDialog({
  @required BuildContext context,
  @required String title,
  @required String description,
  @required String buttonText,
  @required Function onPressed,
  bool isError = true,
}) {
  String sadIconPath = 'assets/images/dialogs/sad.png';
  String errorIconPath = 'assets/images/dialogs/error.png';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: deviceWidth(context) * 0.8,
          height: deviceHeight(context) * 0.35,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 24),
                  child: Image.asset(isError ? errorIconPath : sadIconPath)),
              Text(
                title,
                style: h4(context).copyWith(color: blackShadesColor[80]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 24, left: 24, right: 24),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: body2(context).copyWith(color: blackShadesColor[70]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                width: deviceWidth(context),
                child: ElevatedButton(
                  onPressed: onPressed,
                  style:
                      ElevatedButton.styleFrom(primary: blackShadesColor[10]),
                  child: Text(
                    'button Text',
                    style: body1(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
