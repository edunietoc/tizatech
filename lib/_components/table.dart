import 'package:flutter/material.dart';
import '../shared/colors.dart';
import '../shared/constants.dart';

class TizaTable extends StatelessWidget {
  const TizaTable({
    @required this.dataRows,
    @required this.firstColumnLabel,
    @required this.secondCoulmnLabel,
    Key key,
  }) : super(key: key);

  final String firstColumnLabel;
  final String secondCoulmnLabel;
  final List<TizaDataRow> dataRows;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          side: BorderSide(
            color: blackShadesColor[30],
            width: 1,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <_DataContainer>[
                _DataContainer(
                  data: firstColumnLabel,
                  flex: 3,
                  color: cardColorPrimary,
                ),
                _DataContainer(
                  data: secondCoulmnLabel,
                  flex: 2,
                  color: cardColorPrimary,
                )
              ],
            ),
            Container(
              height: deviceHeight(context) * 0.5,
              width: deviceWidth(context),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: dataRows.length,
                itemBuilder: (_, int index) => Row(
                  children: <Widget>[
                    _DataContainer(
                      data: dataRows[index].label,
                      isColoured: index.isEven,
                      isAlignedLeft: true,
                      flex: 3,
                    ),
                    _DataContainer(
                      data: dataRows[index].value,
                      isColoured: index.isEven,
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class TizaDataRow {
  TizaDataRow({
    @required this.label,
    @required this.value,
  });
  String label;
  dynamic value;
}

class _DataContainer extends StatelessWidget {
  const _DataContainer({
    @required this.data,
    this.isColoured = false,
    this.isAlignedLeft = false,
    this.flex = 1,
    this.color,
    Key key,
  }) : super(key: key);

  final dynamic data;
  final bool isColoured;
  final bool isAlignedLeft;
  final int flex;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
        flex: flex,
        child: Container(
          height: 40,
          color: color ?? (isColoured ? blackShadesColor[05] : Colors.white),
          alignment: isAlignedLeft ? Alignment.centerLeft : Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: data is String ? Text(data) : data,
        ),
      );
}
