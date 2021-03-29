import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            forceElevated: true,
            title: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Regresar',
                textAlign: TextAlign.left,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                child: Text('hello'),
              ),
              childCount: 200,
            ),
          )
        ],
      ),
    );
  }
}
