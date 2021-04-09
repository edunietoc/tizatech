import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tizatech/_components/app_bar.dart';
import 'package:tizatech/shared/colors.dart';
import 'package:tizatech/shared/constants.dart';

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
                    child: SfSparkBarChart(
                      data: [12, 545, 51, 841, 21, 51, 51],
                      color: delaymentsChartColor,
                      axisLineColor: blackShadesColor[20],
                      axisCrossesAt: 0,
                      axisLineWidth: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
