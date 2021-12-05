import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/services/url_launcher.dart';

import '../../_components/app_bar.dart';
import '../../_components/filter_item.dart';
import '../../_components/loader.dart';
import '../../models/messages.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'messages_vm.dart';

class MessagesDetailScreen extends StatelessWidget {
  const MessagesDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<MessagesViewModel>(
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
                                    style: body2(),
                                  )),
                            if (!viewModel.currentMessage.hasBeenAnswered &&
                                !viewModel.userSentThis)
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16,
                                runSpacing: 8,
                                children: viewModel
                                    .currentMessage.responseOptions
                                    .map((String option) => FilterItem(
                                        text: option,
                                        isSelected:
                                            viewModel.answer.contains(option),
                                        onSelected: (bool selection) =>
                                            viewModel.selectAnswer(
                                                option, selection)))
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
                      bottom: 100,
                      left: 24,
                      child: TextButton.icon(
                        icon: viewModel.selectedFilePath == null
                            ? Image.asset('assets/icons/clip.png')
                            : Image.asset('assets/icons/delete.png'),
                        onPressed: () => viewModel.selectedFilePath == null
                            ? viewModel.selectFile()
                            : viewModel.removeSelectedFile(),
                        label: viewModel.selectedFilePath == null
                            ? Text(
                                'Agregar Archivo',
                                style: caption(),
                              )
                            : Text(
                                viewModel.selectedFilePath.split('/').last ??
                                    'Eliminar',
                                style: caption(),
                              ),
                        style: TextButton.styleFrom(
                          backgroundColor: viewModel.selectedFilePath == null
                              ? blackShadesColor[05]
                              : blackShadesColor[10],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              side: BorderSide(
                                color: blackShadesColor[20],
                              )),
                        ),
                      ),
                    ),
                  if (!viewModel.currentMessage.hasBeenAnswered &&
                      !viewModel.userSentThis)
                    Positioned(
                      bottom: 40,
                      right: 24,
                      left: 24,
                      child: ElevatedButton(
                        onPressed: viewModel.buttonFunction,
                        child: Text('Enviar'),
                      ),
                    )
                ],
              ),
            );

          default:
            return Container();
        }
      });
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
          style: body2(),
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
              child: Column(
                children: <Widget>[
                  if (message.answer.contains('file:')) ...<Widget>[
                    RichText(
                      text: TextSpan(
                          style: body1().copyWith(
                            color: blackShadesColor[05],
                          ),
                          children: <TextSpan>[
                            TextSpan(text: message.answerWithoutFile),
                            if (!message.fileIsImage)
                              TextSpan(
                                text: '\n ${message.fileName}',
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => OpenFile.open(message.filePath),
                              )
                          ]),
                    ),
                    if (message.fileIsImage)
                      InkWell(
                          onTap: () => OpenFile.open(message.filePath),
                          child: Image.file(File(message.filePath)))
                  ] else
                    Text(
                      userSentThis ? message.message : message.answer ?? '',
                      style: body1().copyWith(
                        color: blackShadesColor[05],
                      ),
                    ),
                ],
              )),
        ],
      );
}
