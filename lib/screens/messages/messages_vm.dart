import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/screens/messages/message_detail.dart';
import 'package:tizatech/services/navigation.dart';

import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/messages.dart';
import '../../models/user.dart';
import '../../services/message.dart';

enum Status {
  loading,
  done,
  error,
}

class MessagesViewModel extends ChangeNotifier {
  MessagesViewModel() {
    getMessageList();
  }

  final MessageService _messageService = MessageService();
  final User _user = locator<UserService>().user;

  Status _currentStatus = Status.loading;

  String _error;

  List<Message> messageList;

  Message _currentMessage;

  Message get currentMessage => _currentMessage;

  String get error => _error;

  Status get currentStatus => _currentStatus;

  List<dynamic> answer = [];

  set currentStatus(Status status) {
    _currentStatus = status;
    notifyListeners();
  }

  void selectAnswer(String text, bool isSelected) {
    if (isSelected) {
      answer
        ..clear()
        ..add(text);
    } else {
      answer.clear();
    }

    notifyListeners();
  }

  Future<void> submitAnswer() async {
    try {
      currentStatus = Status.loading;
      await _messageService.answerMessage(
          _currentMessage, _user.id, answer.first);
      await getMessageList();
      _currentMessage = messageList.firstWhere(
          (Message message) => message.message == _currentMessage.message);
      notifyListeners();
    } on Exception catch (e) {
      currentStatus = Status.error;
    }
  }

  Future<void> getMessageList() async {
    try {
      messageList = await _messageService.getMessageList(_user.id);
      currentStatus = Status.done;
    } on Exception catch (e) {
      _error = e.toString();
      currentStatus = Status.error;
    }
  }

  Future<void> openMessage(Message message) async {
    BuildContext context = locator<NavigationService>().currentContext;
    try {
      if (!message.hasBeenRead) {
        currentStatus = Status.loading;
        await _messageService.markMessageAsRead(
          message.path,
          _user.id,
        );
        await getMessageList();
      }
      _currentMessage = message;

      await Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => ChangeNotifierProvider<MessagesViewModel>.value(
              value: this,
              child: MessagesDetailScreen(),
            ),
          ));
    } on Exception catch (e) {
      currentStatus = Status.error;
    }
  }
}
