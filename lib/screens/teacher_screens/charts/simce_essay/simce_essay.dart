import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import 'simce_essay_vm.dart';

class SimceScoreChartScreen extends StatelessWidget {
  const SimceScoreChartScreen(this.simceType, {Key key}) : super(key: key);

  final SimceType simceType;
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
                    TizaAppBar(title: 'Ensayo Simce', subtitle: ''),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          ReportChart(
                            series: viewModel.getLanguageSeries(),
                            title: 'Lenguaje',
                            xLabel: 'Años',
                            yLabel: 'Puntaje',
                            chartType: ChartType.yearLine,
                          ),
                          ReportChart(
                            series: viewModel.getMathSeries(),
                            title: 'Matematica',
                            xLabel: 'Años',
                            yLabel: 'Puntaje',
                            chartType: ChartType.yearLine,
                          ),
                          ReportChart(
                            series: viewModel.getHistorySeries(),
                            title: 'Historia',
                            xLabel: 'Años',
                            yLabel: 'Puntaje',
                            chartType: ChartType.yearLine,
                          ),
                          ReportChart(
                            series: viewModel.getScienceSeries(),
                            title: 'Ciencias Naturales',
                            xLabel: 'Años',
                            yLabel: 'Puntaje',
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
