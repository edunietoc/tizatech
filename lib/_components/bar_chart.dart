import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';

class TizaBarChart extends StatelessWidget {
  const TizaBarChart({
    @required this.seriesList,
    @required this.title,
    @required this.xAxisLabel,
    @required this.yAxisLabel,
    @required this.dataIndicators,
    this.isYearly = false,
    Key key,
  }) : super(key: key);

  final List<charts.Series<Object, String>> seriesList;
  final String title;
  final String yAxisLabel;
  final String xAxisLabel;
  final List<DataIndicator> dataIndicators;
  final bool isYearly;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.only(bottom: 32),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: dataIndicators,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 24, bottom: 8),
              child: Text(
                title,
                style: body1(context).copyWith(color: secondaryColor[80]),
              ),
            ),
            Container(
              width: deviceWidth(context),
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                yAxisLabel,
                style: TextStyle(fontSize: 12, color: blackShadesColor[70]),
              ),
            ),
            Container(
              width: deviceWidth(context),
              height: 300,
              child: charts.BarChart(
                seriesList,
                animate: true,
                barGroupingType: charts.BarGroupingType.stacked,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                xAxisLabel,
                style: TextStyle(fontSize: 12, color: blackShadesColor[70]),
              ),
            ),
          ],
        ),
      );
}

class DataIndicator extends StatelessWidget {
  const DataIndicator({
    @required this.color,
    @required this.dataName,
    @required this.dataValue,
    Key key,
  }) : super(key: key);
  final Color color;
  final String dataName;
  final String dataValue;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              color: color,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  dataName,
                  textAlign: TextAlign.left,
                  style: body2(context).copyWith(color: blackShadesColor[70]),
                ),
                SizedBox(height: 4),
                Text(
                  dataValue,
                  textAlign: TextAlign.left,
                  style: h4(context),
                )
              ],
            )
          ],
        ),
      );
}
