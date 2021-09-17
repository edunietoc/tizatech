import 'package:flutter/material.dart';

import '../shared/colors.dart';

typedef OptionCallback = void Function(Option);

class Dropdown extends StatefulWidget {
  const Dropdown({
    @required this.options,
    @required this.label,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  final List<Option> options;
  final String label;
  final OptionCallback onChanged;
  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  dynamic value;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: blackShadesColor[10],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            )),
        child: DropdownButton<Option>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          underline: Container(),
          hint: Text(widget.label),
          items: widget?.options
              ?.map(
                (Option option) => DropdownMenuItem<Option>(
                  value: option,
                  child: Text(option.text),
                ),
              )
              ?.toList(),
          onChanged: (Option selected) {
            setState(() {
              value = selected;
              widget.onChanged(selected);
            });
          },
        ),
      );
}

class Option {
  Option({
    @required this.text,
    @required this.value,
  });

  final String text;
  final dynamic value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Option && other.text == text && other.value == value;
  }

  @override
  int get hashCode => text.hashCode ^ value.hashCode;
}
