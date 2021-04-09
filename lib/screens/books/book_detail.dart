import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(title: 'Consultar Libro', subtitle: 'Literatura'),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('El Principito',
                            style: h3(context).copyWith(
                              color: blackShadesColor[80],
                            )),
                        SizedBox(height: 16),
                        Text('Autor: Antoine de Saint Expoury'),
                        SizedBox(height: 4),
                        Text('Editorial: Planeta'),
                        SizedBox(height: 24),
                        Text(
                          'Descripcion del libro:',
                          style: body1(context).copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam volutpat amet sit purus. Pellentesque at orci tristique non. Id sociis tempus a id nulla. Quis senectus elementum consequat tellus massa.',
                          style: body2(context).copyWith(
                            color: blackShadesColor[70],
                            letterSpacing: 0.27,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton(
                      onPressed: () => print('iplement this'),
                      child: Text('Ver Libro'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
