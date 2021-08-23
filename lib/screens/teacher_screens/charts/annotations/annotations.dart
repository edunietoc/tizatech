import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/utils.dart';
import 'annotations_vm.dart';

class AnnotationsChartScreen extends StatelessWidget {
  const AnnotationsChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AnnotationsViewModel>(
        create: (_) => AnnotationsViewModel(),
        child: Scaffold(
          body: Consumer<AnnotationsViewModel>(
              builder: (_, AnnotationsViewModel viewModel, __) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(slivers: <Widget>[
                  TizaAppBar(
                    title: 'teacherScreens.charts.annotations.title'.tr(),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title: 'teacherScreens.charts.annotations.yearlyTitle'
                            .tr(),
                        subtitle: currentYear(),
                        xLabel: 'teacherScreens.charts.annotations.yearlyXLabel'
                            .tr(),
                        yLabel: 'teacherScreens.charts.annotations.yearlyYLabel'
                            .tr(),
                      ),
                      ReportChart(
                        series: viewModel.getMonthSeries(),
                        title: 'teacherScreens.charts.annotations.monthlyTitle'
                            .tr(),
                        xLabel:
                            'teacherScreens.charts.annotations.monthlyXLabel'
                                .tr(),
                        yLabel:
                            'teacherScreens.charts.annotations.monthlyYLabel'
                                .tr(),
                        subtitle: monthConstants[viewModel.currentMonth],
                        isVertical: false,
                        filterOptions: FilterOptions(
                          options: monthConstants.values.toList(),
                          onChanged: (String value) =>
                              viewModel.setCurrentMonth(value),
                          modalTitle:
                              'teacherScreens.charts.annotations.monthlyFilter.modalTitle'
                                  .tr(),
                          iconText:
                              'teacherScreens.charts.annotations.monthlyFilter.filterText'
                                  .tr(),
                        ),
                      ),
                      ReportChart(
                        series: viewModel.getCourseSeries(),
                        title: 'teacherScreens.charts.annotations.coursesTitle'
                            .tr(),
                        xLabel:
                            'teacherScreens.charts.annotations.coursesXLabel'
                                .tr(),
                        yLabel:
                            'teacherScreens.charts.annotations.coursesYLabel'
                                .tr(),
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title:
                            'teacherScreens.charts.annotations.levelTitle'.tr(),
                        xLabel: 'teacherScreens.charts.annotations.levelXLabel'
                            .tr(),
                        yLabel: 'teacherScreens.charts.annotations.levelYLabel'
                            .tr(),
                        subtitle: viewModel.annotations
                            .levelAnnotations[viewModel.currentLevel].name,
                        filterOptions: FilterOptions(
                          options: viewModel.annotations.levelAnnotations
                              .map((_) => _.name)
                              .toList(),
                          onChanged: (String value) => viewModel.currentLevel =
                              viewModel.annotations.levelAnnotations
                                  .indexWhere((_) => _.name == value),
                          modalTitle:
                              'teacherScreens.charts.annotations.levelFilter.modalTitle'
                                  .tr(),
                          iconText:
                              'teacherScreens.charts.annotations.levelFilter.filterText'
                                  .tr(),
                        ),
                      ),
                      SizedBox(height: 40),
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
