import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import 'internships_vm.dart';

class InternshipChartScreen extends StatelessWidget {
  const InternshipChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<IntershipsViewModel>(
        create: (_) => IntershipsViewModel(),
        child: Scaffold(
          body: Consumer<IntershipsViewModel>(
              builder: (__, IntershipsViewModel viewModel, _) {
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(title: 'Prácticas Anuales', subtitle: ''),
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      ReportChart(
                        series: viewModel
                            .getDataSeries(InternshipTypeData.withInternship),
                        title: 'Hechas',
                        xLabel: 'Cantidad',
                        yLabel: 'Niveles',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel
                            .getDataSeries(InternshipTypeData.noInternship),
                        title: 'Sin hacer',
                        xLabel: 'Cantidad',
                        yLabel: 'Niveles',
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
