import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_components/app_bar.dart';
import '../../_components/avatar_info.dart';
import '../../_components/bar_chart.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/user.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'attendments_vm.dart';

class AttendmentsScreen extends StatelessWidget {
  AttendmentsScreen({Key key}) : super(key: key);
  final User user = locator<UserService>().user;
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AttendementsViewModel>(
        create: (_) => AttendementsViewModel()..getAttendments(),
        builder: (BuildContext context, _) => Consumer<AttendementsViewModel>(
          builder: (BuildContext context, AttendementsViewModel viewModel, _) =>
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
                      if (viewModel.monthSeriesList != null)
                        TizaBarChart(
                          title: 'Abril',
                          xAxisLabel: 'Semanas',
                          yAxisLabel: 'Dias Habiles',
                          seriesList: viewModel.monthSeriesList,
                          dataIndicators: <DataIndicator>[
                            DataIndicator(
                              color: primaryColor,
                              dataName: 'Asistencias',
                              dataValue:
                                  viewModel.totalMonthAttendments.toString(),
                            ),
                            DataIndicator(
                              color: delaymentsChartColor,
                              dataName: 'Inasistencias',
                              dataValue:
                                  viewModel.totalMonthUnattendments.toString(),
                            ),
                          ],
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: 40, left: 24, bottom: 8),
                        child: Text(
                          'Anuales',
                          style:
                              h3(context).copyWith(color: secondaryColor[80]),
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
                              color: primaryColor,
                              dataName: 'Asistencias',
                              dataValue:
                                  viewModel.totalYearAttendments.toString(),
                            ),
                            DataIndicator(
                              color: primaryColor,
                              dataName: 'Inasistencias',
                              dataValue:
                                  viewModel.totalYearUnattendments.toString(),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
