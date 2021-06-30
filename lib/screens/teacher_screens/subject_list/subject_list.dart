import 'package:flutter/material.dart';
import 'package:tizatech/_components/app_bar.dart';
import 'package:tizatech/_components/tile_card.dart';
import 'package:tizatech/models/courses.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({
    @required this.currentCourse,
    Key key,
  }) : super(key: key);

  final Courses currentCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TizaAppBar(title: currentCourse.name, subtitle: ''),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Column(
                  children: List<Widget>.generate(
                    currentCourse.subjectList.length,
                    (int index) => Text(currentCourse.subjectList[index].name),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
