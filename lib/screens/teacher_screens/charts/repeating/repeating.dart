import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/screens/teacher_screens/charts/repeating/repeating_vm.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import '../../../../shared/utils.dart';

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
                    TizaAppBar(title: 'Repitiencia', subtitle: ''),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title: 'Anual',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title: 'Anual',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getRangeSeries(),
                        title: 'Anual',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                        isVertical: false,
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
