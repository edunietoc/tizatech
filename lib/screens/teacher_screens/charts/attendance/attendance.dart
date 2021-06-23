import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import 'attendance_vm.dart';

class AttendanceChartScreen extends StatelessWidget {
  const AttendanceChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AttendanceViewModel>(
        create: (_) => AttendanceViewModel(),
        child: Scaffold(
          body: Consumer<AttendanceViewModel>(
              builder: (_, AttendanceViewModel viewModel, __) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(slivers: <Widget>[
                  TizaAppBar(title: 'Asistencias', subtitle: ''),
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
                          viewModel.getMonthSeries(),
                          vertical: false,
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        child: charts.BarChart(
                          viewModel.getDailySeries(),
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
