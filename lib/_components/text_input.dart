import 'package:flutter/material.dart';

typedef ValidatorType = String Function(String);
typedef OnChangedCallback = void Function(String);

class TextInput extends StatelessWidget {
  const TextInput({
    @required this.hintText,
    @required this.labelText,
    this.onChanged,
    this.icon,
    this.image,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.text,
    this.keyboardType,
    this.errorText,
    this.maxLength,
    this.bottomPadding = 0,
    this.topPadding = 24,
    this.isSearch = false,
    Key key,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final String text;
  final bool enabled;
  final OnChangedCallback onChanged;
  final IconData icon;
  final Image image;
  final bool obscureText;
  final int maxLength;
  final ValidatorType validator;
  final String errorText;
  final double topPadding;
  final double bottomPadding;
  final TextInputType keyboardType;
  final bool isSearch;

  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: TextFormField(
        /* style: TextStyle(color: Colors.blue), */
        maxLength: maxLength,
        /* cursorColor: aquaColor, */
        controller: TextEditingController(text: text),
        enabled: enabled,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: isSearch
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )
              : null,
          labelText: labelText,
          alignLabelWithHint: true,
          hintText: hintText,
          hintMaxLines: 2,
        ),
        onChanged: onChanged,
      ));
}
