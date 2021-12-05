import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/grades_subject.dart';
import '../models/subject.dart';
import '../shared/colors.dart';
import '../shared/constants.dart';

class GradesTable extends StatefulWidget {
  const GradesTable({
    this.subjectList,
    this.gradesList,
    Key key,
  }) : super(key: key);

  final List<Subject> subjectList;
  final List<GradesByStudent> gradesList;

  @override
  _GradesTableState createState() =>
      _GradesTableState(subjectList: subjectList, gradesList: gradesList);
}

class _GradesTableState extends State<GradesTable> {
  _GradesTableState({this.subjectList, this.gradesList});
  final List<Subject> subjectList;
  final List<GradesByStudent> gradesList;
  List<double> heightList;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      heightList = subjectList != null
          ? List<double>.generate(subjectList.length,
              (int index) => subjectList[index].key.currentContext.size.height)
          : List<double>.generate(gradesList.length,
              (int index) => gradesList[index].key.currentContext.size.height);

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
        ),
        padding: EdgeInsets.only(bottom: 38),
        decoration: BoxDecoration(
            color: primaryColor[40],
            border: Border.all(
              width: 1,
              color: blackShadesColor[70],
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: deviceWidth(context) * 0.35,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 0.3))),
              child: Column(
                children: <Widget>[
                  DataContainer(
                    //TODO: localization
                    data: subjectList != null ? 'Asignaturas' : 'Alumnos',
                    color: cardColorPrimary,
                    isMainColumn: true,
                    isHeader: true,
                  ),
                  Column(
                    children: subjectList != null
                        ? List<DataContainer>.generate(
                            widget.subjectList.length,
                            (int index) => DataContainer(
                              data: widget.subjectList[index].name,
                              color: index.isEven
                                  ? blackShadesColor[05]
                                  : Colors.white,
                              isMainColumn: true,
                              key: widget.subjectList[index].key,
                            ),
                          )
                        : List<DataContainer>.generate(
                            widget.gradesList.length,
                            (int index) => DataContainer(
                              data: widget.gradesList[index].student.halfName,
                              color: index.isEven
                                  ? blackShadesColor[05]
                                  : Colors.white,
                              isMainColumn: true,
                              key: widget.gradesList[index].key,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: subjectList != null
                          ? List<DataContainer>.generate(
                              widget.subjectList[0].grades.length + 1,
                              (int index) {
                              if (index >=
                                  widget.subjectList[0].grades.length) {
                                return DataContainer(
                                  data: 'Promedio',
                                  color: cardColorPrimary,
                                  isHeader: true,
                                );
                              }
                              return DataContainer(
                                data: 'Evaluacion ${index + 1}',
                                color: cardColorPrimary,
                                isHeader: true,
                              );
                            })
                          : <Widget>[
                              DataContainer(
                                data: 'Evaluacion',
                                color: cardColorPrimary,
                                isHeader: true,
                              ),
                            ],
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 620),
                      switchInCurve: Curves.elasticOut,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        Animation<Offset> offsetAnimation = Tween<Offset>(
                                begin: Offset(-1, 0), end: Offset(0, 0))
                            .animate(animation);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      child: heightList != null
                          ? Column(
                              children: subjectList != null
                                  ? List<DataContainerRow>.generate(
                                      widget.subjectList.length, (int index) {
                                      Subject currentSubject =
                                          widget.subjectList[index];

                                      return DataContainerRow(
                                        gradesList: currentSubject.grades,
                                        average: currentSubject.average,
                                        height: heightList != null
                                            ? heightList[index]
                                            : null,
                                        color: index.isEven
                                            ? blackShadesColor[05]
                                            : Colors.white,
                                      );
                                    })
                                  : List<DataContainerRow>.generate(
                                      widget.gradesList.length, (int index) {
                                      GradesByStudent currentGrade =
                                          widget.gradesList[index];

                                      return DataContainerRow(
                                        gradesList: <double>[
                                          currentGrade.grade
                                        ],
                                        height: heightList != null
                                            ? heightList[index]
                                            : null,
                                        color: index.isEven
                                            ? blackShadesColor[05]
                                            : Colors.white,
                                        includeAverage: false,
                                      );
                                    }),
                            )
                          : Container(
                              color: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class DataContainer extends StatelessWidget {
  const DataContainer({
    @required this.data,
    this.color,
    this.isMainColumn = false,
    this.isHeader = false,
    Key key,
  }) : super(key: key);

  final String data;
  final Color color;
  final bool isMainColumn;
  final bool isHeader;

  @override
  Widget build(BuildContext context) => Container(
        alignment: isMainColumn ? Alignment.centerLeft : Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        width: isMainColumn ? deviceWidth(context) * 0.35 : 130,
        color: color ?? Colors.transparent,
        child: Text(
          '$data',
          style: body2().copyWith(
              fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400),
        ),
      );
}

class DataContainerRow extends StatelessWidget {
  const DataContainerRow({
    @required this.gradesList,
    this.average,
    this.color,
    this.height,
    this.includeAverage = true,
    Key key,
  }) : super(key: key);
  final List<double> gradesList;
  final Color color;
  final double height;
  final double average;
  final bool includeAverage;
  @override
  Widget build(BuildContext context) => Container(
        color: color ?? Colors.white,
        height: height,
        child: Row(
          children: includeAverage
              ? (List<DataContainer>.generate(
                  gradesList.length,
                  (int index) => DataContainer(
                    data: gradesList[index].toString(),
                  ),
                )..add(DataContainer(data: average.toStringAsFixed(1))))
              : (List<DataContainer>.generate(
                  gradesList.length,
                  (int index) => DataContainer(
                    data: gradesList[index].toString(),
                  ),
                )),
        ),
      );
}
