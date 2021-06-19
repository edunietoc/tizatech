import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/filter_item.dart';
import 'package:tizatech/_components/loader.dart';
import 'package:tizatech/_components/tile_card.dart';
import 'package:tizatech/screens/teacher_screens/subject_list/subject_list.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/avatar_info.dart';
import 'courses_vm.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoursesViewModel>(
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
              body: CustomScrollView(
                slivers: <Widget>[
                  TizaAppBar(
                    title: 'Cursos',
                    subtitle: 'profesor',
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        AvatarInfo(user: viewModel.teacher),
                        Column(
                          children: List<Widget>.generate(
                            viewModel.courseList.length,
                            (int index) => FilterItem(
                              text:
                                  '${viewModel.courseList[index].name} ${viewModel.courseList[index].letter}',
                              isSelected: false,
                              onSelected: (value) => print,
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
}
