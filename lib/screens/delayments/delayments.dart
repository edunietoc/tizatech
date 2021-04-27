import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../_components/bar_chart.dart';
import '../../_components/loader.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'delayments_vm.dart';

class DelaymentScreen extends StatelessWidget {
  DelaymentScreen({Key key}) : super(key: key);
  final User user = locator<UserService>().user;
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<DelaymentsViewModel>(
        create: (_) => DelaymentsViewModel()..getDelayments(),
        builder: (BuildContext context, _) => Consumer<DelaymentsViewModel>(
            builder: (BuildContext context, DelaymentsViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.error:
              return Text(viewModel.error);

            case Status.loading:
              return Loader();

            case Status.done:
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(title: 'Asistencias', subtitle: 'Alumno'),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          Column(
                            children: <Widget>[
                              AvatarInfo(
                                user: user,
                                profileImage: Image.network(user.picturePath),
                                showId: true,
                                description:
                                    'Visualiza de forma mesual y anual todas las asistencias e inasistencias.',
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 24, bottom: 8),
                            child: Text(
                              'Mensuales',
                              style: h3(context)
                                  .copyWith(color: secondaryColor[80]),
                            ),
                          ),
                          if (viewModel.monthSeriesList != null)
                            TizaBarChart(
                              title: 'Abril',
                              xAxisLabel: 'Semanas',
                              yAxisLabel: 'Dias Habiles',
                              seriesList: viewModel.monthSeriesList,
                              dataIndicators: <DataIndicator>[
                                DataIndicator(
                                  color: delaymentsChartColor,
                                  dataName: 'Retrasos',
                                  dataValue:
                                      viewModel.totalMonthDelayments.toString(),
                                ),
                              ],
                            ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 24, bottom: 8),
                            child: Text(
                              'Anuales',
                              style: h3(context)
                                  .copyWith(color: secondaryColor[80]),
                            ),
                          ),
                          if (viewModel.yearSeriesList != null)
                            TizaBarChart(
                              seriesList: viewModel.yearSeriesList,
                              title: DateTime.now().year.toString(),
                              xAxisLabel: 'Meses',
                              yAxisLabel: 'Dias Habiles',
                              dataIndicators: <DataIndicator>[
                                DataIndicator(
                                  color: delaymentsChartColor,
                                  dataName: 'Retrasos',
                                  dataValue:
                                      viewModel.totalYearDelayments.toString(),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
          }
        }),
      );
}
