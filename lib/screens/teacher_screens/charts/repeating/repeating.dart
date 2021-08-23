import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import '../../../../shared/utils.dart';
import 'repeating_vm.dart';

class RepeatingChartScreen extends StatelessWidget {
  const RepeatingChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<RepeatingViewModel>(
        create: (_) => RepeatingViewModel(),
        child: Scaffold(
          body: Consumer<RepeatingViewModel>(
              builder: (__, RepeatingViewModel viewModel, _) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: 'teacherScreens.charts.repeating.title'.tr(),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title:
                            'teacherScreens.charts.repeating.annualTitle'.tr(),
                        subtitle: currentYear(),
                        xLabel:
                            'teacherScreens.charts.repeating.annualXLabel'.tr(),
                        yLabel:
                            'teacherScreens.charts.repeating.annualYLabel'.tr(),
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title:
                            'teacherScreens.charts.repeating.levelTitle'.tr(),
                        xLabel:
                            'teacherScreens.charts.repeating.levelXLabel'.tr(),
                        yLabel:
                            'teacherScreens.charts.repeating.levelYLabel'.tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getRangeSeries(),
                        title:
                            'teacherScreens.charts.repeating.rangeTitle'.tr(),
                        xLabel:
                            'teacherScreens.charts.repeating.rangeXLabel'.tr(),
                        yLabel:
                            'teacherScreens.charts.repeating.rangeYLabel'.tr(),
                        isVertical: false,
                      ),
                      SizedBox(height: 40),
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
