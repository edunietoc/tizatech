import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_components/app_bar.dart';
import '../../_components/loader.dart';
import '../../_components/message.dart';
import '../../_components/search_input.dart';
import '../../models/messages.dart';
import 'messages_vm.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<MessagesViewModel>(
        create: (_) => MessagesViewModel(),
        child: Consumer<MessagesViewModel>(
            builder: (_, MessagesViewModel viewModel, __) {
          switch (viewModel.currentStatus) {
            case Status.loading:
              return Loader();

            case Status.error:
              return Text(viewModel.error);

            case Status.done:
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(title: 'Mensajes', subtitle: ''),
                    SliverToBoxAdapter(
                      child: SearchBar(
                        hintText: 'Buscar',
                        onChanged: (String text) =>
                            viewModel.filterMessages(text),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        (viewModel.isMessageFiltered
                                ? viewModel.filteredMessage
                                : viewModel.messageList)
                            .map(
                              (Message message) => MessageTile(
                                hasBeenRead: message.hasBeenRead,
                                message: message,
                                onTap: () => viewModel.openMessage(message),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );

            default:
              return Container();
          }
        }),
      );
}
