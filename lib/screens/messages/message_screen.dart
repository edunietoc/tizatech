import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/loader.dart';
import 'package:tizatech/screens/messages/message_detail.dart';
import 'package:tizatech/screens/messages/messages_vm.dart';

import '../../_components/app_bar.dart';
import '../../_components/message.dart';
import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/messages.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(locator<UserService>().user.id);
    print(locator<UserService>().user.firstName);
    return ChangeNotifierProvider<MessagesViewModel>(
      create: (_) => MessagesViewModel(),
      child: Consumer<MessagesViewModel>(
          builder: (BuildContext context, MessagesViewModel viewModel, _) {
        switch (viewModel.currentStatus) {
          case Status.loading:
            return Loader();

          case Status.error:
            return Text(viewModel.error);

          case Status.done:
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  TizaAppBar(title: 'Mensajes', subtitle: ''),
                  SliverPadding(padding: EdgeInsets.only(top: 32)),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      viewModel.messageList
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
        }
      }),
    );
  }
}
