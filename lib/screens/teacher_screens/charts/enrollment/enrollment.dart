import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/report_bar_chart.dart';
import 'package:tizatech/shared/utils.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import 'enrollment_vm.dart';

class EnrollmentChartScreen extends StatelessWidget {
  const EnrollmentChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<EnrollmentViewModel>(
        create: (_) => EnrollmentViewModel(),
        child: Scaffold(
          body: Consumer<EnrollmentViewModel>(
              builder: (__, EnrollmentViewModel viewModel, _) {
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
                      ReportBarChart(
                        series: viewModel.getAnualSeries(),
                        title: 'Anual',
                        subtitle: currentYear(),
                        xLabel: 'Años',
                        yLabel: 'Alumnos',
                      ),
                      ReportBarChart(
                        series: viewModel.getCoursesSeries(),
                        title: 'Por Curso',
                        xLabel: 'Curso',
                        yLabel: 'Numero de Alumnos',
                        isVertical: false,
                        height: 500,
                      ),
                      ReportBarChart(
                        series: viewModel.getLevelSeries(),
                        title: 'Por Nivel',
                        xLabel: 'Nivel',
                        yLabel: 'Numero de Alumnos',
                        isVertical: false,
                      ),
                      Container(
                          width: 300,
                          height: 300,
                          child: charts.PieChart(
                            viewModel.getGenderSeries(),
                            animate: true,
                          )),
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
