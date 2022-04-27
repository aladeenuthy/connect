import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/helpers/helpers.dart';
import 'package:connect/helpers/onesignal_helper.dart';
import 'package:connect/models/last_message.dart';
import 'package:connect/models/models.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatHelper {
  static final _accessToDB = FirebaseFirestore.instance.collection('messages');

  // reference to the messages db and converting it to Message model type
  static CollectionReference<Message> _messagesRef(String convoId) {
    return _accessToDB.doc(convoId).collection('chats').withConverter<Message>(
        fromFirestore: (snapshot, _) => Message.fromFirestore(
            snapshot.data() as Map<String, dynamic>, snapshot.id),
        toFirestore: (message, _) => message.toJson());
  }

  // get messages between 2 users
  static Stream<QuerySnapshot<Message>> getMessages(String convoId) {
    return _messagesRef(convoId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // get last messages to display preview of each convo with each user
  static Stream<QuerySnapshot<LastMessage>> getLastMessages() {
    return _accessToDB
        .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .withConverter<LastMessage>(
            fromFirestore: ((snapshot, _) {
              final Map<String, dynamic> lastMessage =
                  snapshot.data()!['last_message'];
              final receiver = ChatUser.fromFirestore(
                  FirebaseAuth.instance.currentUser!.uid ==
                          lastMessage['senderId']
                      ? lastMessage['receiverCred']
                      : lastMessage['senderCred']);
              return LastMessage.fromFirestore(lastMessage, receiver);
            }),
            toFirestore: (lastMessage, _) => lastMessage.toJson())
        .orderBy('last_message.timestamp', descending: true)
        .snapshots();
  }

  // 2 types of message (image and text) , checks and process before pushing to firestore,also set that message as the last message and pushes notification
  static Future<void> sendMessage(
      String content, String contentType, ChatUser receiver,
      [File? image]) async {
    final convoId =
        getConvoId(FirebaseAuth.instance.currentUser!.uid, receiver.userId);
    if (contentType == 'image') {
      final ref = FirebaseStorage.instance
          .ref()
          .child('messages')
          .child(convoId)
          .child(image!.path.split("/").last);
      await ref.putFile(image);
      final imageUrl = await ref.getDownloadURL();
      content = imageUrl;
    }
    final message = Message(
        id: '',
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: receiver.userId,
        contentType: contentType,
        content: content,
        isRead: false,
        timestamp: Timestamp.now());

    final currentUser = await UserHelper.getUser(FirebaseAuth
        .instance
        .currentUser!
        .uid); // so when other user clicks notification it directly take user to view chat
    final batch = FirebaseFirestore.instance.batch();
    final docRef = _accessToDB.doc(convoId).collection('chats').doc();

    final lastMessageJson = message.toJson();
    lastMessageJson.addAll({
      'senderCred': currentUser.toJson(),
      'receiverCred': receiver.toJson()
    });
    // combining write operations to create documents at once
    batch.set(docRef, message.toJson());
    batch.set(_accessToDB.doc(convoId), {
      'last_message': lastMessageJson,
      'users': [message.senderId, message.receiverId]
    });
    await batch.commit();
    await OneSignalHelper.sendPushNotification(
        content: contentType == 'image' ? 'sent an image' : content,
        receiverDeviceToken: receiver.deviceToken,
        userData: currentUser.toJson(),
        bigPicture: contentType == 'image' ? content : '');
  }

  static void markMessageAsRead(String convoId, String messageId) {
    FirebaseFirestore.instance
        .collection('messages/$convoId/chats')
        .doc(messageId)
        .update({'isRead': true});
  }

  static void markLastMessageAsRead(String convoId) async {
    final getDoc = await _accessToDB.doc(convoId).get();
    if (!getDoc.exists) {
      return;
    }
    final lastMessage = getDoc.data()!['last_message'];
    if (lastMessage['isRead'] ||
        lastMessage['senderId'] == FirebaseAuth.instance.currentUser!.uid) {
      return;
    }
    getDoc.reference.set({
      'last_message': {
        'senderId': lastMessage['senderId'],
        "receiverId": lastMessage['receiverId'],
        "contentType": lastMessage['contentType'],
        "content": lastMessage['content'],
        "isRead": true,
        'timestamp': lastMessage['timestamp'],
        'senderCred': lastMessage['senderCred'],
        'receiverCred': lastMessage['receiverCred'],
      },
      'users': [lastMessage['senderId'], lastMessage['receiverId']]
    });
  }

  // stream of number of unread to show count of unread messages to receiver
  static Stream<QuerySnapshot<Map<String, dynamic>>> numberOfUnread(
      String convoId) {
    return _accessToDB
        .doc(convoId)
        .collection('chats')
        .where(
          'receiverId',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .where('isRead', isEqualTo: false)
        .snapshots();
  }
}
