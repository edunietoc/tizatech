import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    TizaAppBar(title: 'Matricula', subtitle: ''),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.language),
                        title: 'Lenguaje',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.math),
                        title: 'Matematica',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.science),
                        title: 'Ciencias Naturales',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.men),
                        title: 'MEN',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.mandatory),
                        title: 'Obligatorias',
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDataSeries(PTUType.ranking),
                        title: 'Ranking',
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
