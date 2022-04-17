import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/utils/chat_helper.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/message.dart';

class MessageBubble extends StatelessWidget {
  final String convoId;
  final Message message;
  const MessageBubble({Key? key, required this.convoId, required this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isUser = isMe(message.senderId, FirebaseAuth.instance.currentUser!.uid);
    if (!message.isRead && message.receiverId == FirebaseAuth.instance.currentUser!.uid) {
      ChatHelper.markMessageAsRead(convoId, message.id);
    }
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 160,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                  bottomLeft: isUser
                      ? const Radius.circular(25)
                      : Radius.zero,
                  bottomRight:
                      isUser ? Radius.zero : const Radius.circular(25)),
              color: isUser ? shadePrimaryColor : Colors.grey[400]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            message.contentType == 'text' ? Text(
                message.content,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ): SizedBox(
                width: double.infinity,
                height: 150,
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(15) ,
                  child: CachedNetworkImage(imageUrl: message.content,fit: BoxFit.cover,)),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  const Text("12:00"),
                  const SizedBox(
                    width: 5,
                  ),
                  if (isUser)
                    Icon(message.isRead ? Icons.done_all : Icons.done,
                        color: kPrimaryColor, size: 15)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
