import 'package:flutter/material.dart';

import '../../models/subject.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';

class GradesTable extends StatelessWidget {
  const GradesTable({
    @required this.subjectList,
    Key key,
  }) : super(key: key);

  final List<Subject> subjectList;

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
                    data: 'Asignaturas',
                    color: cardColorPrimary,
                    isMainColumn: true,
                    isHeader: true,
                  ),
                  Column(
                    children: List<DataContainer>.generate(
                      subjectList.length,
                      (int index) => DataContainer(
                        data: subjectList[index].name,
                        color:
                            index.isEven ? blackShadesColor[05] : Colors.white,
                        isMainColumn: true,
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
                      children: List<DataContainer>.generate(
                        8,
                        (int index) => DataContainer(
                          data: 'Evaluacion $index',
                          color: cardColorPrimary,
                          isHeader: true,
                        ),
                      ),
                    ),
                    Column(
                      children: List<DataContainerRow>.generate(
                        subjectList.length,
                        (int index) => DataContainerRow(
                          gradesList: subjectList[index].grades,
                          color: index.isEven
                              ? blackShadesColor[05]
                              : Colors.white,
                        ),
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
          style: body2(context).copyWith(
              fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400),
        ),
      );
}

class DataContainerRow extends StatelessWidget {
  const DataContainerRow({
    this.gradesList,
    this.color,
    Key key,
  }) : super(key: key);
  final List<double> gradesList;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        color: color ?? Colors.white,
        child: Row(
          children: List<DataContainer>.generate(
            gradesList.length,
            (int index) => DataContainer(
              data: gradesList[index].toString(),
            ),
          ),
        ),
      );
}
