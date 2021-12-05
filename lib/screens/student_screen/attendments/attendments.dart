import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/avatar_info.dart';
import '../../../_components/bar_chart.dart';
import '../../../_components/loader.dart';
import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/user.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
import '../../error/error_screen.dart';
import 'attendments_vm.dart';

class AttendmentsScreen extends StatelessWidget {
  const AttendmentsScreen({this.userParam, Key key}) : super(key: key);
  final User userParam;
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AttendementsViewModel>(
        create: (_) =>
            AttendementsViewModel(userParam: userParam)..getAttendments(),
        builder: (BuildContext context, _) => Consumer<AttendementsViewModel>(
            builder:
                (BuildContext context, AttendementsViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.error:
              return ErrorScreen(
                errorDescription: viewModel.errorDescription,
                errorImage: viewModel.errorImage,
                errorTitle: viewModel.errorTitle,
                screenTitle: 'studentScreens.attendments.title'.tr(),
                user: viewModel.user,
              );

            case Status.loading:
              return Loader();

            case Status.done:
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(title: 'studentScreens.attendments.title'.tr()),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          Column(
                            children: <Widget>[
                              AvatarInfo(
                                user: viewModel.user,
                                profileImage: locator<UserService>()
                                    .getUserAvatar(userParam: userParam),
                                showId: true,
                                description:
                                    'studentScreens.attendments.avatarDescription'
                                        .tr(),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 24, bottom: 8),
                            child: Text(
                              'studentScreens.attendments.monthlyTitle'.tr(),
                              style: h3().copyWith(color: secondaryColor[80]),
                            ),
                          ),
                          if (viewModel.monthSeriesList != null)
                            TizaBarChart(
                              //TODO: Place current Month here
                              title: 'Abril',
                              xAxisLabel:
                                  'studentScreens.attendments.weeksLabel'.tr(),
                              yAxisLabel:
                                  'studentScreens.attendments.daysLabel'.tr(),
                              seriesList: viewModel.monthSeriesList,
                              dataIndicators: <DataIndicator>[
                                DataIndicator(
                                  color: primaryColor,
                                  dataName:
                                      'studentScreens.attendments.title'.tr(),
                                  dataValue: viewModel.totalMonthAttendments
                                      .toString(),
                                ),
                                DataIndicator(
                                  color: delaymentsChartColor,
                                  dataName:
                                      'studentScreens.attendments.unattendments'
                                          .tr(),
                                  dataValue: viewModel.totalMonthUnattendments
                                      .toString(),
                                ),
                              ],
                            ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 24, bottom: 8),
                            child: Text(
                              'studentScreens.attendments.yearlyTitle'.tr(),
                              style: h3().copyWith(color: secondaryColor[80]),
                            ),
                          ),
                          if (viewModel.yearSeriesList != null)
                            TizaBarChart(
                              seriesList: viewModel.yearSeriesList,
                              title: DateTime.now().year.toString(),
                              xAxisLabel:
                                  'studentScreens.attendments.monthsLabel'.tr(),
                              yAxisLabel:
                                  'studentScreens.attendments.daysLabel'.tr(),
                              dataIndicators: <DataIndicator>[
                                DataIndicator(
                                  color: primaryColor,
                                  dataName:
                                      'studentScreens.attendments.title'.tr(),
                                  dataValue:
                                      viewModel.totalYearAttendments.toString(),
                                ),
                                DataIndicator(
                                  color: delaymentsChartColor,
                                  dataName:
                                      'studentScreens.attendments.unattendments'
                                          .tr(),
                                  dataValue: viewModel.totalYearUnattendments
                                      .toString(),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            default:
              return Container();
          }
        }),
      );
}
