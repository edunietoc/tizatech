import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import 'ptu_vm.dart';

class PTUChartScreen extends StatelessWidget {
  const PTUChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<PTUViewModel>(
        create: (_) => PTUViewModel(),
        child: Scaffold(
          body:
              Consumer<PTUViewModel>(builder: (__, PTUViewModel viewModel, _) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: 'teacherScreens.charts.ptu.title'.tr(),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.language),
                        title: 'teacherScreens.charts.ptu.language'.tr(),
                        xLabel: 'teacherScreens.charts.ptu.xLabel'.tr(),
                        yLabel: 'teacherScreens.charts.ptu.yLabel'.tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.math),
                        title: 'teacherScreens.charts.ptu.math'.tr(),
                        xLabel: 'teacherScreens.charts.ptu.xLabel'.tr(),
                        yLabel: 'teacherScreens.charts.ptu.yLabel'.tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.science),
                        title: 'teacherScreens.charts.ptu.science'.tr(),
                        xLabel: 'teacherScreens.charts.ptu.xLabel'.tr(),
                        yLabel: 'teacherScreens.charts.ptu.yLabel'.tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.men),
                        title: 'teacherScreens.charts.ptu.men'.tr(),
                        xLabel: 'teacherScreens.charts.ptu.xLabel'.tr(),
                        yLabel: 'teacherScreens.charts.ptu.yLabel'.tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.mandatory),
                        title: 'teacherScreens.charts.ptu.mandatory'.tr(),
                        xLabel: 'teacherScreens.charts.ptu.xLabel'.tr(),
                        yLabel: 'teacherScreens.charts.ptu.yLabel'.tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.ranking),
                        title: 'teacherScreens.charts.ptu.ranking'.tr(),
                        xLabel: 'teacherScreens.charts.ptu.xLabel'.tr(),
                        yLabel: 'teacherScreens.charts.ptu.yLabel'.tr(),
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
