import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import 'personal_improvement_vm.dart';

class PersonalImpChartScreen extends StatelessWidget {
  const PersonalImpChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<PersonalImpViewModel>(
        create: (_) => PersonalImpViewModel(),
        child: Scaffold(
          body: Consumer<PersonalImpViewModel>(
              builder: (__, PersonalImpViewModel viewModel, _) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: 'teacherScreens.charts.improvement.title'.tr(),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getDataSeries(),
                        title: 'teacherScreens.charts.improvement.annualTitle'
                            .tr(),
                        xLabel: 'teacherScreens.charts.improvement.xLabel'.tr(),
                        yLabel: 'teacherScreens.charts.improvement.yLabel'.tr(),
                        isVertical: false,
                        height: 500,
                      ),
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
