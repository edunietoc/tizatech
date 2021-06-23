import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/app_bar.dart';
import 'package:tizatech/_components/loader.dart';
import 'package:tizatech/screens/teacher_screens/charts/enrollment/enrollment_vm.dart';

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
                      Container(
                          width: 300,
                          height: 300,
                          child: charts.BarChart(
                            viewModel.getAnualSeries(),
                          )),
                      Container(
                          width: 300,
                          height: 300,
                          child: charts.BarChart(
                            viewModel.getCoursesSeries(),
                            vertical: false,
                          )),
                      Container(
                          width: 300,
                          height: 300,
                          child: charts.BarChart(
                            viewModel.getLevelSeries(),
                            vertical: false,
                          )),
                      Container(
                          width: 300,
                          height: 300,
                          child: charts.PieChart(
                            viewModel.getGenderSeries(),
                          )),
                    ]))
                  ],
                );
                break;
              default:
            }
          }),
        ),
      );
}
