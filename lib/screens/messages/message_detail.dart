import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/filter_item.dart';
import 'package:tizatech/_components/loader.dart';
import 'package:tizatech/models/messages.dart';

import '../../_components/app_bar.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'messages_vm.dart';

class MessagesDetailScreen extends StatelessWidget {
  const MessagesDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MessagesViewModel>(
        builder: (BuildContext context, MessagesViewModel viewModel, _) {
      switch (viewModel.currentStatus) {
        case Status.loading:
          return Loader();

        case Status.error:
          return Text('error');

        case Status.done:
          return Scaffold(
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    TizaAppBar(
                      title: viewModel.currentMessage.userSender.halfName,
                      subtitle: viewModel.currentMessage.title,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          SizedBox(
                            height: 32,
                          ),
                          if (viewModel.userSentThis)
                            _SendedMessage(
                              message: viewModel.currentMessage,
                              userSentThis: viewModel.userSentThis,
                            )
                          else
                            _ReceivedMessage(
                              message: viewModel.currentMessage,
                            ),
                          if (viewModel.currentMessage.hasBeenAnswered)
                            _SendedMessage(message: viewModel.currentMessage),
                          if (!viewModel.currentMessage.hasBeenAnswered &&
                              !viewModel.userSentThis)
                            Container(
                                margin: EdgeInsets.only(top: 32, bottom: 16),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Seleccione una Respuesta:',
                                  style: body2(context),
                                )),
                          if (!viewModel.currentMessage.hasBeenAnswered &&
                              !viewModel.userSentThis)
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 16,
                              runSpacing: 8,
                              children: viewModel.currentMessage.responseOptions
                                  .map((String option) => FilterItem(
                                      text: option,
                                      isSelected:
                                          viewModel.answer.contains(option),
                                      onSelected: (bool selection) => viewModel
                                          .selectAnswer(option, selection)))
                                  .toList(),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                if (!viewModel.currentMessage.hasBeenAnswered &&
                    !viewModel.userSentThis)
                  Positioned(
                    bottom: 40,
                    right: 24,
                    left: 24,
                    child: ElevatedButton(
                      onPressed: () => viewModel.submitAnswer(),
                      child: Text('Enviar'),
                    ),
                  )
              ],
            ),
          );

        default:
      }
    });
  }
}

class _ReceivedMessage extends StatelessWidget {
  const _ReceivedMessage({
    @required this.message,
    Key key,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
            color: blackShadesColor[10],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )),
        child: Text(
          message.message,
          style: body2(context),
        ),
      );
}

class _SendedMessage extends StatelessWidget {
  const _SendedMessage({
    @required this.message,
    this.userSentThis = false,
    Key key,
  }) : super(key: key);
  final Message message;
  final bool userSentThis;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
                color: primaryColor[80],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                )),
            child: Text(
              userSentThis ? message.message : message.answer,
              style: body1(context).copyWith(
                color: blackShadesColor[05],
              ),
            ),
          ),
        ],
      );
}

/* class _AnswerOption extends StatelessWidget {
  const _AnswerOption({@required this.text, Key key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor[80],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: body2(context).copyWith(
          color: primaryColor[80],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
 */
