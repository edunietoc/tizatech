import 'package:flutter/material.dart';
import 'package:tizatech/_components/app_bar.dart';

class RepeatingChartsScreen extends StatelessWidget {
  const RepeatingChartsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(title: 'Repitiencia'),
            SliverList(delegate: SliverChildListDelegate([]))
          ],
        ),
      );
}
