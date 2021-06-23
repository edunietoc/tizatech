import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
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
                  TizaAppBar(title: 'Cumplimiento', subtitle: ''),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        width: 300,
                        height: 300,
                        child: charts.BarChart(
                          viewModel.getAnualSeries(),
                          vertical: false,
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        child: charts.BarChart(
                          viewModel.getCourseSeries(),
                          vertical: false,
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        child: charts.BarChart(
                          viewModel.getLevelSeries(),
                          vertical: false,
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        child: charts.BarChart(
                          viewModel.getMonthSeries(),
                          vertical: false,
                        ),
                      ),
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
