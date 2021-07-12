import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    @required this.text,
    @required this.onPressed,
    this.padding,
    Key key,
  }) : super(key: key);
  final Function onPressed;
  final String text;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
        ),
      );
}
