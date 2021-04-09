import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_components/app_bar.dart';
import '../../models/attendments.dart';
import '../../shared/constants.dart';
import 'attendments_vm.dart';

class AttendmentsScreen extends StatelessWidget {
  const AttendmentsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AttendementsViewModel>(
        create: (context) => AttendementsViewModel()..getMonthAttendments(),
        builder: (BuildContext context, _) => Consumer<AttendementsViewModel>(
          builder: (BuildContext context, AttendementsViewModel viewModel, _) =>
              Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                TizaAppBar(title: 'Asistencias', subtitle: 'Alumno'),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            width: deviceWidth(context),
                            height: deviceHeight(context) * 0.5,
                            child: viewModel.attendmentsMonthSeriesList != null
                                ? charts.BarChart(
                                    viewModel.attendmentsMonthSeriesList,
                                    animate: true,
                                  )
                                : CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
