import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/shared/utils.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
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
                    TizaAppBar(title: 'Repitencia Último Año', subtitle: ''),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title: 'Anual',
                        subtitle: currentYear(),
                        xLabel: 'Años',
                        yLabel: 'Porcentaje',
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title: 'Por Nivel',
                        xLabel: 'Porcentaje',
                        yLabel: 'Nivel',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getRangeSeries(),
                        title: 'Por Rango',
                        xLabel: 'Alumnos',
                        yLabel: 'Rango',
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
