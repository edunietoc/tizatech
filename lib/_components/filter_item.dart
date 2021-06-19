import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/constants.dart';

class FilterItem extends StatefulWidget {
  const FilterItem({
    @required this.text,
    @required this.isSelected,
    @required this.onSelected,
    this.showCheckMark = false,
    Key key,
  }) : super(key: key);
  final String text;
  final bool isSelected;
  final Function onSelected;
  final bool showCheckMark;
  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) => FilterChip(
        backgroundColor: cardColorPrimary,
        disabledColor: cardColorPrimary,
        selected: widget.isSelected ?? false,
        selectedColor: primaryColor[80],
        showCheckmark: widget.showCheckMark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onSelected: (bool isSelected) => widget.onSelected(isSelected),
        side: BorderSide(color: primaryColor[80]),
        label: Text(
          widget.text,
          style: body2(context).copyWith(
            color: widget.isSelected ? blackShadesColor[05] : primaryColor[80],
          ),
          textAlign: TextAlign.center,
        ),
      );
}
