import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

import 'abstract_convo.dart';

class LastMessage extends Convo {
  final ChatUser receiver;
  LastMessage(
      {required String senderId,
      required String receiverId,
      required String contentType,
      required String content,
      required bool isRead,
      required Timestamp timestamp,
      required this.receiver})
      : super(
            senderId: senderId,
            receiverId: receiverId,
            contentType: contentType,
            content: content,
            isRead: isRead,
            timestamp: timestamp);
  factory LastMessage.fromFirestore(
      Map<String, dynamic> document, ChatUser receiver) {
    return LastMessage(
        senderId: document['senderId'],
        receiverId: document['receiverId'],
        contentType: document['contentType'],
        content: document['content'],
        isRead: document['isRead'],
        timestamp: document['timestamp'],
        receiver: receiver
        );
  }
}
