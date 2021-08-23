import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import 'simce_essay_vm.dart';

class SimceScoreChartScreen extends StatelessWidget {
  const SimceScoreChartScreen(this.simceType, {Key key}) : super(key: key);

  final SimceType simceType;

  static final Map<SimceType, String> simceMap = <SimceType, String>{
    SimceType.essay: 'teacherScreens.charts.simce.essay'.tr(),
    SimceType.score: 'teacherScreens.charts.simce.score'.tr()
  };
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<SimceViewModel>(
        create: (_) => SimceViewModel(simceType),
        child: Scaffold(
          body: Consumer<SimceViewModel>(
              builder: (__, SimceViewModel viewModel, _) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: simceMap[simceType],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          ReportChart(
                            series: viewModel.getLanguageSeries(),
                            title: 'teacherScreens.charts.simce.language'.tr(),
                            xLabel: 'teacherScreens.charts.simce.xLabel'.tr(),
                            yLabel: 'teacherScreens.charts.simce.yLabel'.tr(),
                            chartType: ChartType.yearLine,
                          ),
                          ReportChart(
                            series: viewModel.getMathSeries(),
                            title: 'teacherScreens.charts.simce.math'.tr(),
                            xLabel: 'teacherScreens.charts.simce.xLabel'.tr(),
                            yLabel: 'teacherScreens.charts.simce.yLabel'.tr(),
                            chartType: ChartType.yearLine,
                          ),
                          ReportChart(
                            series: viewModel.getHistorySeries(),
                            title: 'teacherScreens.charts.simce.history'.tr(),
                            xLabel: 'teacherScreens.charts.simce.xLabel'.tr(),
                            yLabel: 'teacherScreens.charts.simce.yLabel'.tr(),
                            chartType: ChartType.yearLine,
                          ),
                          ReportChart(
                            series: viewModel.getScienceSeries(),
                            title: 'teacherScreens.charts.simce.science'.tr(),
                            xLabel: 'teacherScreens.charts.simce.xLabel'.tr(),
                            yLabel: 'teacherScreens.charts.simce.yLabel'.tr(),
                            chartType: ChartType.yearLine,
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    )
                  ],
                );

              default:
                return Container();
            }
          }),
        ),
      );
}
