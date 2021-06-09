import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/messages.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Message>> getMessageList(int id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('chats')
          .where('apod_array', arrayContains: id)
          .get();

      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        Message message = Message.fromMap(doc.data());

        List<dynamic> listMap =
            doc.data()['has_been_answered_by'] as List<dynamic>;

        listMap?.forEach((dynamic element) {
          if (element['id'] == id) {
            message
              ..hasBeenAnswered = true
              ..answer = element['respuesta'];
          }
        });

        message
          ..hasBeenRead =
              (doc.data()['has_been_read_by'] as List<dynamic>)?.contains(id) ??
                  false
          ..path = doc.reference.path;
        print('has been answered ${message.hasBeenAnswered}');
        return message;
      }).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> markMessageAsRead(String path, int id) async {
    try {
      await _firestore.doc(path).update(<String, dynamic>{
        'has_been_read_by': FieldValue.arrayUnion(<int>[id])
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> answerMessage(Message message, int id, String answer) async {
    try {
      await _firestore.doc(message.path).update(<String, dynamic>{
        'has_been_answered_by': FieldValue.arrayUnion(<Map<String, dynamic>>[
          <String, dynamic>{
            'id': id,
            'respuesta': answer,
          },
        ])
      });
    } on Exception catch (_) {
      rethrow;
    }
  }
}
