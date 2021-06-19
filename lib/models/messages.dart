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
  });
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      title: map['titulo'],
      message: map['mensaje'],
      time: map['time'],
      date: map['date'],
      userSender: User.fromMap(map['created_by_dict']),
      responseOptions: (map['respuestas_array'] as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
      dateTime: DateTime.parse(map['date']),
    );
  }

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  final String title;
  final String message;
  final String time;
  final String date;
  final User userSender;
  final List<String> responseOptions;
  bool hasBeenRead = false;
  bool hasBeenAnswered = false;
  String path;
  String answer;
  DateTime dateTime;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'time': time,
      'date': date,
      'userSender': userSender.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
