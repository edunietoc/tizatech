import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import '../../../../shared/utils.dart';
import 'attendance_vm.dart';

class AttendanceChartScreen extends StatelessWidget {
  AttendanceChartScreen(this.attendanceType, {Key key}) : super(key: key);
  final AttendanceType attendanceType;

  final Map<AttendanceType, String> textType = <AttendanceType, String>{
    AttendanceType.attendance:
        'teacherScreens.charts.attendance.attendance'.tr(),
    AttendanceType.unattendance:
        'teacherScreens.charts.attendance.unnatendance'.tr(),
    AttendanceType.delayment:
        'teacherScreens.charts.attendance.delayments'.tr(),
  };

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AttendanceViewModel>(
        create: (_) => AttendanceViewModel(attendanceType),
        child: Scaffold(
          body: Consumer<AttendanceViewModel>(
              builder: (_, AttendanceViewModel viewModel, __) {
            String diaryText = attendanceType == AttendanceType.delayment
                ? 'teacherScreens.charts.attendance.dailyM'.tr()
                : 'teacherScreens.charts.attendance.dailyF'.tr();
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(shrinkWrap: true, slivers: <Widget>[
                  TizaAppBar(
                    title: '${textType[attendanceType]}',
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title:
                            'teacherScreens.charts.attendance.annualTitle'.tr(),
                        subtitle: currentYear(),
                        xLabel: 'teacherScreens.charts.attendance.annualXLabel'
                            .tr(args: <String>[textType[attendanceType]]),
                        yLabel: 'teacherScreens.charts.attendance.annualYLabel'
                            .tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getMonthSeries(),
                        title: 'teacherScreens.charts.attendance.monthlyTitle'
                            .tr(),
                        subtitle: currentMonth(),
                        xLabel: 'teacherScreens.charts.attendance.monthlyXLabel'
                            .tr(args: <String>[textType[attendanceType]]),
                        yLabel: 'teacherScreens.charts.attendance.monthlyYLabel'
                            .tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDailySeries(),
                        title: '$diaryText',
                        subtitle: currentMonth(),
                        xLabel: 'teacherScreens.charts.attendance.dailyXLabel'
                            .tr(args: <String>[
                          textType[attendanceType],
                          diaryText
                        ]),
                        yLabel:
                            'teacherScreens.charts.attendance.dailyYLabel'.tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title:
                            'teacherScreens.charts.attendance.levelTitle'.tr(),
                        xLabel: 'teacherScreens.charts.attendance.levelXLabel'
                            .tr(args: <String>[textType[attendanceType]]),
                        yLabel:
                            'teacherScreens.charts.attendance.levelYLabel'.tr(),
                        isVertical: false,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
                  ),
                ]);
              default:
                return Container();
            }
          }),
        ),
      );
}
