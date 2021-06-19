import 'package:flutter/material.dart';

import '../shared/custom_types.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    @required this.hintText,
    @required this.onChanged,
    Key key,
  }) : super(key: key);
  final String hintText;
  final VoidString onChanged;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: Image.asset('assets/icons/search.png'),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.grey,
              ))),
        ),
      );
}
