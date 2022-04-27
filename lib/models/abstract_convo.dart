import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class Convo {
  final String senderId, receiverId, contentType, content;
  final bool isRead;
  final Timestamp timestamp;
  Convo(
      {required this.senderId,
      required this.receiverId,
      required this.contentType,
      required this.content,
      required this.isRead,
      required this.timestamp});

  String get date {
    return DateFormat.jm().format(timestamp.toDate());
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
