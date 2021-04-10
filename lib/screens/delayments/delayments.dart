import 'package:flutter/material.dart';
import 'package:tizatech/_components/avatar_info.dart';
import 'package:tizatech/_components/bar_chart.dart';
import 'package:tizatech/locator/locator.dart';
import 'package:tizatech/locator/user_service.dart';
import 'package:tizatech/models/user.dart';
import 'package:tizatech/screens/delayments/delayments_vm.dart';
import 'package:tizatech/shared/colors.dart';
import 'package:provider/provider.dart';

import '../../_components/app_bar.dart';
import '../../shared/constants.dart';

class DelaymentScreen extends StatelessWidget {
  DelaymentScreen({Key key}) : super(key: key);
  final User user = locator<UserService>().user;
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<DelaymentsViewModel>(
        create: (_) => DelaymentsViewModel()..getMonthdelayments(),
        builder: (BuildContext context, _) => Consumer<DelaymentsViewModel>(
          builder: (BuildContext context, DelaymentsViewModel viewModel, _) =>
              Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                TizaAppBar(title: 'Asistencias', subtitle: 'Alumno'),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Column(
                        children: <Widget>[
                          AvatarInfo(
                            firstName: user.firstName,
                            lastName: user.lastName,
                            profileImage: Image.network(user.picturePath),
                            showId: true,
                            id: user.rut,
                            description:
                                'Visualiza de forma mesual y anual todas las asistencias e inasistencias.',
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40, left: 24, bottom: 8),
                        child: Text(
                          'Mensuales',
                          style:
                              h3(context).copyWith(color: secondaryColor[80]),
                        ),
                      ),
                      if (viewModel.delaymentsMonthSeriesList != null)
                        TizaBarChart(
                          title: 'Abril',
                          xAxisLabel: 'Semanas',
                          yAxisLabel: 'Dias Habiles',
                          seriesList: viewModel.delaymentsMonthSeriesList,
                          dataIndicators: <DataIndicator>[
                            DataIndicator(
                              color: delaymentsChartColor,
                              dataName: 'Retrasos',
                              dataValue: viewModel.totalDelayments.toString(),
                            ),
                          ],
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
