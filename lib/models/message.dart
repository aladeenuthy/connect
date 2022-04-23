import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Message {
  final String id, senderId, receiverId, contentType, content;
  final bool isRead;
  final Timestamp timestamp;
  Message(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.contentType,
      required this.content,
      required this.isRead,
      required this.timestamp});
  String get date {
    return DateFormat.jm().format(timestamp.toDate());
  }

  factory Message.fromFirestore(Map<String, dynamic> document, String id) {
    return Message(
        id: id,
        senderId: document['senderId'],
        receiverId: document['receiverId'],
        contentType: document['contentType'],
        content: document['content'],
        isRead: document['isRead'],
        timestamp: document['timestamp']);
  }
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      "receiverId": receiverId,
      "contentType": contentType,
      "content": content,
      "isRead": isRead,
      'timestamp': timestamp
    };
  }
}
