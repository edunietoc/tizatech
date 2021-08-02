import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/shared/utils.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import '../../../../shared/constants.dart';
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
                    delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title: 'Anotaciones Anuales',
                        subtitle: currentYear(),
                        xLabel: 'Número',
                        yLabel: 'Faltas',
                      ),
                      ReportChart(
                        series: viewModel.getMonthSeries(),
                        title: 'Cursos con Faltas Graves',
                        xLabel: 'Número de Anotaciones',
                        yLabel: 'Curso',
                        subtitle: monthConstants[viewModel.currentMonth],
                        isVertical: false,
                        filterOptions: FilterOptions(
                          options: monthConstants.values.toList(),
                          onChanged: (String value) =>
                              viewModel.setCurrentMonth(value),
                          modalTitle: 'Filtrar Mes',
                          iconText: 'Mes',
                        ),
                      ),
                      ReportChart(
                        series: viewModel.getCourseSeries(),
                        title: 'Anotaciones por Curso',
                        xLabel: 'Número de Faltas Graves',
                        yLabel: 'Cursos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title: 'Anotaciones por Nivel',
                        xLabel: 'Número',
                        yLabel: 'Faltas',
                        subtitle: viewModel.annotations
                            .levelAnnotations[viewModel.currentLevel].name,
                        filterOptions: FilterOptions(
                          options: viewModel.annotations.levelAnnotations
                              .map((_) => _.name)
                              .toList(),
                          onChanged: (String value) => viewModel.currentLevel =
                              viewModel.annotations.levelAnnotations
                                  .indexWhere((_) => _.name == value),
                          modalTitle: 'Filtrar Nivel',
                          iconText: 'Nivel',
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
