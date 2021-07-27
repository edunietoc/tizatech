import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/colors.dart';
import '../../../../shared/constants.dart';

enum ChartType {
  bar,
  yearLine,
  valueLine,
}

class ReportBarChart extends StatelessWidget {
  const ReportBarChart({
    @required this.series,
    @required this.title,
    @required this.xLabel,
    @required this.yLabel,
    this.chartType = ChartType.bar,
    this.subtitle,
    this.isVertical = true,
    this.height = 350,
    Key key,
  }) : super(key: key);

  final List<charts.Series<dynamic, dynamic>> series;
  final String title;
  final String xLabel;
  final String yLabel;
  final String subtitle;
  final bool isVertical;
  final double height;
  final ChartType chartType;

  dynamic getChartType() {
    switch (chartType) {
      case ChartType.bar:
        return charts.BarChart(
          series,
          vertical: isVertical,
          behaviors: [
            charts.ChartTitle(
              yLabel,
              titleOutsideJustification: charts.OutsideJustification.start,
              titleStyleSpec: charts.TextStyleSpec(
                fontSize: 14,
                color: charts.Color.fromHex(code: '#515B59'),
                fontWeight: '700',
              ),
            ),
          ],
        );

      case ChartType.yearLine:
        return charts.TimeSeriesChart(
          series,
          animate: true,
          dateTimeFactory: DateFactoryYear(),
        );
      default:
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            width: deviceWidth(context),
            padding: const EdgeInsets.only(left: 24, bottom: 16),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: h3(context).copyWith(
                color: secondaryColor[80],
              ),
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: body1(context).copyWith(
                color: blackShadesColor[70],
                fontWeight: FontWeight.w500,
              ),
            ),
          Container(
            width: deviceWidth(context),
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: getChartType(),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            xLabel,
            style: caption(context).copyWith(
                color: blackShadesColor[70], fontWeight: FontWeight.w500),
          )
        ],
      );
}

class DateFactoryYear extends charts.DateTimeFactory {
  @override
  DateTime createDateTime(int year,
          [int month = 1,
          int day = 1,
          int hour = 0,
          int minute = 0,
          int second = 0,
          int millisecond = 0,
          int microsecond = 0]) =>
      DateTime(year, month, day);

  @override
  DateTime createDateTimeFromMilliSecondsSinceEpoch(
          int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  @override
  DateFormat createDateFormat(String pattern) => DateFormat.y();
}
