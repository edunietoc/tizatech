import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/button.dart';
import '../../../_components/loader.dart';
import '../../../_components/text_input.dart';
import 'search_teacher_vm.dart';

class SearchTeacherScreen extends StatelessWidget {
  const SearchTeacherScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<SearchTeacherViewModel>(
        create: (_) => SearchTeacherViewModel(),
        child: Scaffold(
          body: Consumer<SearchTeacherViewModel>(
            builder: (_, SearchTeacherViewModel viewModel, __) {
              switch (viewModel.currentStatus) {
                case Status.loading:
                  return Loader();

                case Status.error:
                  return Text('error');

                case Status.done:
                  return CustomScrollView(
                    slivers: <Widget>[
                      TizaAppBar(title: 'Busqueda', subtitle: ''),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32, bottom: 16, left: 24, right: 24),
                              child: Text(
                                  'Para buscar un profresor(a) utilice cualquiera de los tres campos.'),
                            ),
                            TextInput(
                              hintText: 'Nombre',
                              labelText: 'Nombre',
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, bottom: 24),
                              onChanged: (String value) =>
                                  viewModel.firstName = value,
                            ),
                            TextInput(
                              hintText: 'Apellido',
                              labelText: 'Apellido',
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, bottom: 24),
                              onChanged: (String value) =>
                                  viewModel.lastName = value,
                            ),
                            TextInput(
                              hintText: 'Rut',
                              labelText: 'Rut',
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, bottom: 24),
                              onChanged: (String value) =>
                                  viewModel.rut = value,
                            ),
                            Button(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 48, horizontal: 24),
                              onPressed: () => viewModel.search(),
                              text: 'Buscar',
                            )
                          ],
                        ),
                      )
                    ],
                  );

                default:
                  return Container();
              }
            },
          ),
        ),
      );
}
