import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/colors.dart';
import '../../../../shared/constants.dart';
import '../locator/locator.dart';
import '../services/navigation.dart';

enum ChartType {
  bar,
  yearLine,
  valueLine,
}

class FilterOptions {
  FilterOptions({
    @required this.options,
    @required this.onChanged,
    @required this.modalTitle,
    @required this.iconText,
  });
  final List<String> options;
  final String modalTitle;
  final String iconText;
  final StringCallback onChanged;
}

class ReportChart extends StatelessWidget {
  const ReportChart({
    @required this.series,
    @required this.title,
    @required this.xLabel,
    @required this.yLabel,
    this.chartType = ChartType.bar,
    this.subtitle,
    this.isVertical = true,
    this.height = 350,
    this.filterOptions,
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
  final FilterOptions filterOptions;

  dynamic getChartType() {
    switch (chartType) {
      case ChartType.bar:
        return charts.BarChart(
          series,
          vertical: isVertical,
          // ignore: always_specify_types
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
            padding: const EdgeInsets.only(left: 24, bottom: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: h3(context).copyWith(
                      color: secondaryColor[80],
                    ),
                  ),
                ),
                if (filterOptions != null)
                  TextButton(
                      onPressed: () {
                        bottomSheet(
                          context,
                          filterOptions.options,
                          filterOptions.onChanged,
                          filterOptions.modalTitle,
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            filterOptions.iconText,
                            style: caption(context)
                                .copyWith(color: primaryColor[80]),
                          ),
                          SizedBox(width: 6),
                          Image.asset('assets/icons/filter.png')
                        ],
                      )),
              ],
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

typedef StringCallback = void Function(String);

void bottomSheet(
  BuildContext context,
  List<String> options,
  StringCallback onChanged,
  String title,
) {
  BuildContext _context =
      context ?? locator<NavigationService>().currentContext;
  String _selectedValue = options[0];
  showBottomSheet(
    context: _context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Container(
        width: deviceWidth(context),
        height: deviceHeight(context) / 3,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                      child: IconButton(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: primaryColor),
                  )),
                  Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: body1(context).copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(
              color: blackShadesColor[20],
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: options
                    .map((_) => InkWell(
                          child: ListTile(
                            title: Text(_, style: body1(context)),
                            trailing: Radio<String>(
                              groupValue: _selectedValue,
                              value: _,
                              onChanged: (String value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                                onChanged(value);
                              },
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
