import 'package:flutter/material.dart';
import 'package:tizatech/_components/app_bar.dart';
import 'package:tizatech/models/courses.dart';
import 'package:tizatech/screens/teacher_screens/grades/grades.dart';
import 'package:tizatech/shared/colors.dart';

class SubjectSelectionScreen extends StatelessWidget {
  const SubjectSelectionScreen({
    @required this.course,
    Key key,
  }) : super(key: key);

  final Courses course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        TizaAppBar(title: 'Notas', subtitle: course.name),
        SliverList(
          delegate: SliverChildListDelegate(course.subjectList
              .map((TeacherSubject subject) => ListTile(
                    title: Text(
                      subject.name,
                    ),
                    tileColor: blackShadesColor[05],
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (_) => TeacherGradesScreen(
                            subject: subject,
                          ),
                        )),
                  ))
              .toList()),
        )
      ],
    ));
  }
}
