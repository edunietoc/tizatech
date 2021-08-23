import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/avatar_info.dart';
import '../../../_components/grades_table.dart';
import '../../../_components/loader.dart';
import '../../../locator/locator.dart';
import '../../../locator/user_service.dart';
import '../../../models/user.dart';
import '../../../shared/colors.dart';
import '../../../shared/constants.dart';
import '../../error/error_screen.dart';
import 'grades_vm.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({this.userParam, Key key}) : super(key: key);

  final User userParam;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<GradesViewModel>(
        create: (_) =>
            GradesViewModel(userParam: userParam)..getStudentGrades(),
        builder: (BuildContext context, _) => Consumer<GradesViewModel>(
            builder: (BuildContext context, GradesViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.error:
              return ErrorScreen(
                errorDescription: viewModel.errorDescription,
                errorImage: viewModel.errorImage,
                errorTitle: viewModel.errorTitle,
                screenTitle: 'studentScreens.grades.title'.tr(),
                user: viewModel.user,
              );

            case Status.loading:
              return Loader();

            case Status.done:
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(title: 'studentScreens.grades.title'.tr()),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          AvatarInfo(
                            user: viewModel.user,
                            profileImage: locator<UserService>()
                                .getUserAvatar(userParam: userParam),
                            description:
                                'studentScreens.grades.avatarDescription'.tr(),
                          ),
                          if (viewModel.gradeAverage != null)
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'studentScreens.grades.averageTitle'.tr(),
                                  style: h4(context).copyWith(
                                    color: secondaryColor[80],
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: viewModel.gradeAverage
                                            .toStringAsFixed(1),
                                        style: h4(context)
                                            .copyWith(color: blackShadesColor)),
                                  ],
                                ),
                              ),
                            ),
                          if (viewModel.subjectList != null)
                            GradesTable(subjectList: viewModel.subjectList),
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
