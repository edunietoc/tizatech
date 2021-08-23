import 'package:charts_flutter/flutter.dart' as charts;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import '../../../../shared/utils.dart';
import 'enrollment_vm.dart';

class EnrollmentChartScreen extends StatelessWidget {
  const EnrollmentChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<EnrollmentViewModel>(
        create: (_) => EnrollmentViewModel(),
        child: Scaffold(
          body: Consumer<EnrollmentViewModel>(
              builder: (__, EnrollmentViewModel viewModel, _) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: 'teacherScreens.charts.enrollment.title'.tr(),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title:
                            'teacherScreens.charts.enrollment.annualTitle'.tr(),
                        subtitle: currentYear(),
                        xLabel: 'teacherScreens.charts.enrollment.annualXLabel'
                            .tr(),
                        yLabel: 'teacherScreens.charts.enrollment.annualYLabel'
                            .tr(),
                      ),
                      ReportChart(
                        series: viewModel.getCoursesSeries(),
                        title:
                            'teacherScreens.charts.enrollment.courseTitle'.tr(),
                        xLabel: 'teacherScreens.charts.enrollment.courseXLabel'
                            .tr(),
                        yLabel: 'teacherScreens.charts.enrollment.courseYLabel'
                            .tr(),
                        isVertical: false,
                        height: 500,
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title:
                            'teacherScreens.charts.enrollment.levelTitle'.tr(),
                        xLabel:
                            'teacherScreens.charts.enrollment.levelXLabel'.tr(),
                        yLabel:
                            'teacherScreens.charts.enrollment.levelYLabel'.tr(),
                        isVertical: false,
                      ),
                      //TODO: fix this chart
                      Container(
                          width: 300,
                          height: 300,
                          child: charts.PieChart(
                            viewModel.getGenderSeries(),
                            animate: true,
                          )),
                    ]))
                  ],
                );
                break;
              default:
                return Container();
            }
          }),
        ),
      );
}
