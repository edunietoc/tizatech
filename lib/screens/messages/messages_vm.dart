import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator/locator.dart';
import '../../locator/user_service.dart';
import '../../models/messages.dart';
import '../../models/user.dart';
import '../../services/message.dart';
import '../../services/navigation.dart';
import 'message_detail.dart';

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

  List<Message> _messageList;

  List<Message> get messageList => _messageList;

  List<Message> _filteredMessages;

  List<Message> get filteredMessage => _filteredMessages;

  bool _isMessageFiltered = false;

  bool get isMessageFiltered => _isMessageFiltered;
  set isMessageFiltered(bool isFiltered) {
    _isMessageFiltered = isFiltered;
    notifyListeners();
  }

  Message _currentMessage;

  int get id => _user.id;

  bool get userSentThis => _user.id == _currentMessage.userSender.id;
  Message get currentMessage => _currentMessage;

  String get error => _error;

  Status get currentStatus => _currentStatus;

  List<dynamic> answer = <dynamic>[];

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
      await _messageService.answerMessage(_currentMessage, _user, answer.first);
      await getMessageList();
      _currentMessage = messageList.firstWhere(
          (Message message) => message.message == _currentMessage.message);
      notifyListeners();
    } on Exception catch (e) {
      //TODO: implement error screen
      currentStatus = Status.error;
    }
  }

  Future<void> getMessageList() async {
    try {
      _messageList =
          await _messageService.getMessageList(_user.id, _user.schoolId)
            ..sort((Message a, Message b) => b.dateTime.compareTo(a.dateTime));
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

  void filterMessages(String text) {
    if (text.isEmpty) {
      isMessageFiltered = false;
    } else {
      RegExp regExp = RegExp(
        '$text',
        caseSensitive: false,
      );
      _filteredMessages = _messageList
          .where(
            (Message message) =>
                regExp.hasMatch(message.userSender.halfName) ||
                regExp.hasMatch(message.title),
          )
          .toList();
      isMessageFiltered = true;
    }
  }
}
