import 'package:flutter/material.dart';
import 'package:tizatech/_components/app_bar.dart';
import 'package:tizatech/models/courses.dart';
import 'package:tizatech/models/user.dart';
import 'package:tizatech/screens/home/home.dart';
import 'package:tizatech/shared/colors.dart';

class TeacherStudentListScreen extends StatelessWidget {
  const TeacherStudentListScreen({
    @required this.course,
    Key key,
  }) : super(key: key);

  final Courses course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TizaAppBar(title: '${course.name} ${course.letter}', subtitle: ''),
          SliverList(
              delegate: SliverChildListDelegate(course.studentList
                  .map((Student student) => Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: ListTile(
                          title: Text(student.fullName),
                          tileColor: blackShadesColor[05],
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                builder: (_) => HomeScreen(
                                  userParam: student,
                                ),
                              )),
                        ),
                      ))
                  .toList()))
        ],
      ),
    );
  }
}
