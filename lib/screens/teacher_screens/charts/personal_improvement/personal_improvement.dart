import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import 'personal_improvement_vm.dart';

class PersonalImpChartScreen extends StatelessWidget {
  const PersonalImpChartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<PersonalImpViewModel>(
        create: (_) => PersonalImpViewModel(),
        child: Scaffold(
          body: Consumer<PersonalImpViewModel>(
              builder: (__, PersonalImpViewModel viewModel, _) {
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
                        series: viewModel.getDataSeries(),
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
