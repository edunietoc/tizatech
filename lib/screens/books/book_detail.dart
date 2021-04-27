import 'package:flutter/material.dart';

import '../../_components/app_bar.dart';
import '../../models/book.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'books_vm.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({
    @required this.book,
    @required this.viewModel,
    Key key,
  }) : super(key: key);
  final Book book;
  final BooksViewModel viewModel;
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
                        Text(book.title,
                            style: h3(context).copyWith(
                              color: blackShadesColor[80],
                            )),
                        SizedBox(height: 16),
                        Text('Autor:'),
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
                          book.description,
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
                      onPressed: () => viewModel.launchUrl(book.url),
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
