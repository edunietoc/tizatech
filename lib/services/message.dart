import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import '../models/messages.dart';
import '../models/user.dart';
import 'api.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final API _api = API();

  Future<List<Message>> getMessageList(int id, int schooldId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('chats')
          .where('apod_array', arrayContains: id)
          .where('establecimiento_id', isEqualTo: schooldId)
          .get();

      QuerySnapshot<Map<String, dynamic>> sendedSnapshot = await _firestore
          .collection('chats')
          .where('created_by_dict.id', isEqualTo: '$id')
          .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> list = snapshot.docs
        ..addAll(sendedSnapshot.docs);

      return list.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        Message message = Message.fromMap(doc.data());

        if (message.userSender.id == id) {
          message.hasBeenRead = true;
          return message;
        }

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

  Future<void> answerMessage(Message message, User user, String answer,
      {String filePath}) async {
    const String endpoint = 'respuestasmensaje/';
    try {
      String answerMessage =
          filePath != null ? '$answer \nfile: $filePath' : answer;
      await _firestore.doc(message.path).update(<String, dynamic>{
        'has_been_answered_by': FieldValue.arrayUnion(<Map<String, dynamic>>[
          <String, dynamic>{
            'id': user.id,
            'respuesta': answerMessage,
          },
        ])
      });

      Map<String, dynamic> body = <String, String>{
        'apoderado': user.id.toString(),
        'respuesta': answer,
        'mensaje': message.path.substring(6),
        'establecimiento': user.schoolId.toString()
      };

      if (filePath != null) {
        String extension = filePath?.split('/')?.last?.split('.')?.last;
        print('extension $extension');

        print(extension);
        await _api.multipartPost(
          endpoint,
          <MultipartFile>[
            await MultipartFile.fromPath(
              'adjuntos',
              filePath,
            ),
          ],
          body,
        );
      } else {
        await _api.post(endpoint, body);
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
