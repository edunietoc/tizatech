import 'dart:convert';

import 'user.dart';

class Message {
  Message({
    this.title,
    this.message,
    this.time,
    this.userSender,
    this.date,
    this.responseOptions,
    this.dateTime,
    this.replyHasAttachment,
  });
  factory Message.fromMap(Map<String, dynamic> map) => Message(
        title: map['titulo'],
        message: map['mensaje'],
        time: map['time'],
        date: map['date'],
        userSender: User.fromMap(map['created_by_dict']),
        responseOptions: (map['respuestas_array'] as List<dynamic>)
            .map((dynamic e) => e.toString())
            .toList(),
        dateTime: DateTime.parse(map['date']),
        replyHasAttachment: map['replyhasAttachment'] ?? false,
      );

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  final String title;
  final String message;
  final String time;
  final String date;
  final User userSender;
  final List<String> responseOptions;
  final bool replyHasAttachment;
  bool hasBeenRead = false;
  bool hasBeenAnswered = false;
  String path;
  String answer;
  DateTime dateTime;

  String get answerWithoutFile => answer.split('file:').first;

  String get filePath =>
      answer.contains('file:') ? answer.split('file:').last.trim() : null;

  String get fileName => filePath?.split('/')?.last;

  bool get fileIsImage =>
      (fileName?.endsWith('.png') ?? false) ||
      (fileName?.endsWith('.jpg') ?? false) ||
      (fileName?.endsWith('.jpeg') ?? false);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'message': message,
        'time': time,
        'date': date,
        'userSender': userSender.toMap(),
      };

  String toJson() => json.encode(toMap());
}
