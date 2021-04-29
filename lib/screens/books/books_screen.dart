import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/screens/error/error_screen.dart';

import '../../_components/app_bar.dart';
import '../../_components/loader.dart';
import '../../_components/text_input.dart';
import '../../_components/tile_card.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'book_detail.dart';
import 'books_vm.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<BooksViewModel>(
        create: (_) => BooksViewModel()..init(),
        child: Consumer<BooksViewModel>(
            builder: (BuildContext context, BooksViewModel viewModel, _) {
          switch (viewModel.currentStatus) {
            case Status.error:
              return ErrorScreen(
                errorDescription: viewModel.errorDescription,
                errorImage: viewModel.errorImage,
                errorTitle: viewModel.errorTitle,
                screenSubtitle: 'Alumno',
                screenTitle: 'Lecturas Anuales',
                user: locator<UserService>().user,
              );

            case Status.loading:
              return Loader();

            case Status.done:
              return Scaffold(
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
                          if (viewModel.bookList != null)
                            Column(
                              children: List<TileCard>.generate(
                                viewModel.bookList.length,
                                (int index) => TileCard(
                                  title: viewModel.bookList[index].title,
                                  description:
                                      viewModel.bookList[index].description,
                                  iconPath: 'assets/images/books/books.png',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute<Widget>(
                                      builder: (_) => BookDetailScreen(
                                        book: viewModel.bookList[index],
                                        viewModel: Provider.of<BooksViewModel>(
                                            context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              );
          }
        }),
      );
}
