import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/locator/locator.dart';
import 'package:tizatech/locator/user_service.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/avatar_info.dart';
import '../../../_components/filter_item.dart';
import '../../../_components/loader.dart';
import 'courses_vm.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<CoursesViewModel>(
        create: (_) => CoursesViewModel(),
        child: Consumer<CoursesViewModel>(
            builder: (BuildContext context, CoursesViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.loading:
              return Loader();

            case Status.error:
              return Text('Error');

            case Status.done:
              return Scaffold(
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(vertical: 28, horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () => viewModel.selectCourse(),
                    child: Text('teacherScreens.courses.button'.tr()),
                  ),
                ),
                body: CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: 'teacherScreens.courses.title'.tr(),
                      //TODO: this sub?
                      subtitle: 'teacherScreens.courses.subtitle'.tr(),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          AvatarInfo(
                            user: viewModel.teacher,
                            profileImage: locator<UserService>()
                                .getUserAvatar(userParam: viewModel.teacher),
                          ),
                          Column(
                            children: List<Widget>.generate(
                              viewModel.courseList.length,
                              (int index) => FilterItem(
                                text:
                                    '${viewModel.courseList[index].name} ${viewModel.courseList[index].letter}',
                                isSelected:
                                    index == viewModel?.currentIndexCourse,
                                onSelected: (bool value) =>
                                    viewModel.currentIndexCourse = index,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return Container();
          }
        }),
      );
}
