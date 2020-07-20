import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatModel {
  final String message;
  final String time;
  final bool isUser;
  final DateTime dateTime;

  ChatModel({this.message, this.time, this.isUser, this.dateTime});

  factory ChatModel.fromMap({Map<String, dynamic> map}) {
    DateTime date =
        new DateTime.fromMillisecondsSinceEpoch(map['time'].seconds * 1000);
    var format = DateFormat.jm();
    var correctDate = format.format(date);
    return ChatModel(
      message: map["message"] ?? "",
      time: correctDate,
      isUser: map['isUser'] ?? true,
      dateTime: date,
    );
  }

  factory ChatModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    Map<String, dynamic> map = documentSnapshot.data;
    return ChatModel.fromMap(map: map);
  }

  static List<ChatModel> fromQuerySnapshot({QuerySnapshot querySnapshot}) {
    List<DocumentSnapshot> documents = querySnapshot.documents;
    List<ChatModel> list = documents
        .map((f) => ChatModel.fromDocumentSnapshot(documentSnapshot: f))
        .toList();
    return list;
  }

  static Map<String, dynamic> toMap({String message}) {
    return {'message': message, 'isUser': true, 'time': Timestamp.now()};
  }
}
