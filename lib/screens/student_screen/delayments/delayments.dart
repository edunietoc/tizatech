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
import 'delayments_vm.dart';

class DelaymentScreen extends StatelessWidget {
  const DelaymentScreen({this.userParam, Key key}) : super(key: key);
  final User userParam;
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<DelaymentsViewModel>(
        create: (_) =>
            DelaymentsViewModel(userParam: userParam)..getDelayments(),
        builder: (BuildContext context, _) => Consumer<DelaymentsViewModel>(
            builder: (BuildContext context, DelaymentsViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.error:
              return ErrorScreen(
                errorDescription: viewModel.errorDescription,
                errorImage: viewModel.errorImage,
                errorTitle: viewModel.errorTitle,
                screenTitle: 'studentScreens.delayments.title'.tr(),
                user: viewModel.user,
              );

            case Status.loading:
              return Loader();

            case Status.done:
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(title: 'studentScreens.delayments.title'.tr()),
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
                                    'studentScreens.delayments.avatarDescription'
                                        .tr(),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 24, bottom: 8),
                            child: Text(
                              'studentScreens.delayments.monthlyTitle'.tr(),
                              style: h3(context)
                                  .copyWith(color: secondaryColor[80]),
                            ),
                          ),
                          if (viewModel.monthSeriesList != null)
                            TizaBarChart(
                              //TODO: place current month
                              title: 'Abril',
                              xAxisLabel:
                                  'studentScreens.delayments.weeksLabel'.tr(),
                              yAxisLabel:
                                  'studentScreens.delayments.daysLabel'.tr(),
                              seriesList: viewModel.monthSeriesList,
                              dataIndicators: <DataIndicator>[
                                DataIndicator(
                                  color: delaymentsChartColor,
                                  dataName:
                                      'studentScreens.delayments.title'.tr(),
                                  dataValue:
                                      viewModel.totalMonthDelayments.toString(),
                                ),
                              ],
                            ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 24, bottom: 8),
                            child: Text(
                              'studentScreens.delayments.title'.tr(),
                              style: h3(context)
                                  .copyWith(color: secondaryColor[80]),
                            ),
                          ),
                          if (viewModel.yearSeriesList != null)
                            TizaBarChart(
                              seriesList: viewModel.yearSeriesList,
                              title: DateTime.now().year.toString(),
                              xAxisLabel:
                                  'studentScreens.delayments.monthsLabel'.tr(),
                              yAxisLabel:
                                  'studentScreens.delayments.daysLabel'.tr(),
                              dataIndicators: <DataIndicator>[
                                DataIndicator(
                                  color: delaymentsChartColor,
                                  dataName:
                                      'studentScreens.delayments.title'.tr(),
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

            default:
              return Container();
          }
        }),
      );
}
