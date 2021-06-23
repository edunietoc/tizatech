import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import 'simce_essay_vm.dart';

class SimceScoreChartScreen extends StatelessWidget {
  const SimceScoreChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<SimceViewModel>(
        create: (_) => SimceViewModel(),
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
                          Container(
                            width: 300,
                            height: 300,
                            child: charts.LineChart(
                              viewModel.getLanguageSeries(),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 300,
                            child: charts.LineChart(
                              viewModel.getHistorySeries(),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 300,
                            child: charts.LineChart(
                              viewModel.getMathSeries(),
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 300,
                            child: charts.LineChart(
                              viewModel.getScienceSeries(),
                            ),
                          ),
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
