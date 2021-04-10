import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../_components/text_input.dart';
import '../../_components/tile_card.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'book_detail.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            TizaAppBar(title: 'Lecturas Anuales', subtitle: 'Alumno'),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(24, 32, 24, 40),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Busca por asignatura y visualiza todas las lecturas de consulta proporcionadaspor tus profesores.',
                            style: body1(context)
                                .copyWith(color: blackShadesColor[70]),
                          ),
                          TextInput(
                            hintText: 'Busca un Libro',
                            labelText: 'Asignatura',
                            isSearch: true,
                          ),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.only(
                      left: 24,
                      bottom: 20,
                    ),
                    child: Text(
                      'Literatura',
                      style: h3(context).copyWith(
                        color: secondaryColor[80],
                      ),
                    ),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                            builder: (_) => BookDetailScreen())),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookDetailScreen())),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookDetailScreen())),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookDetailScreen())),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookDetailScreen())),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailScreen(),
                        )),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookDetailScreen())),
                  ),
                  TileCard(
                    title: 'El Principito',
                    description: 'Antoine de Saint-Exupery',
                    author: 'author: Antoine de Saint-Exupery',
                    iconPath: 'assets/images/books/books.png',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookDetailScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
