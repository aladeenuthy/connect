import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/screens/home/components/unread_badge.dart';
import 'package:connect/helpers/helpers.dart';
import 'package:connect/utils/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/last_message.dart';
import '../../../utils/constants.dart';


class UserChat extends StatelessWidget {
  final bool isUser;
  final LastMessage lastMessage;
  const UserChat({Key? key, required this.isUser, required this.lastMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final receiver = lastMessage.receiver;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 80,
      width: double.infinity,
      child: Row(children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: shadePrimaryColor,
          backgroundImage: CachedNetworkImageProvider(receiver.profileUrl),
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(receiver.username,
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                if (isUser)
                  Icon(lastMessage.isRead ? Icons.done_all : Icons.done,
                      color: kPrimaryColor, size: 15),
                const SizedBox(
                  width: 5,
                ),
                lastMessage.contentType == 'text'
                    ? Text(
                        lastMessage.content.length > 20
                            ? lastMessage.content.substring(0, 10) + "..."
                            : lastMessage.content,
                        style: const TextStyle(
                          color: shadePrimaryColor,
                          fontSize: 16,
                        ))
                    : const Icon(
                        Icons.photo_album,
                        color: kPrimaryColor,
                        size: 20,
                      ),
              ],
            )
          ],
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(lastMessage.date,
                style: const TextStyle(
                  color: shadePrimaryColor,
                  fontSize: 14,
                )),
            if (lastMessage.receiverId ==
                    FirebaseAuth.instance.currentUser!.uid &&
                !lastMessage.isRead)
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ChatHelper.numberOfUnread(getConvoId(
                      FirebaseAuth.instance.currentUser!.uid, receiver.userId)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return UnreadBadge(
                          count: snapshot.data!.docs.length.toString());
                    } else {
                      return const Text("");
                    }
                  })
          ],
        )
      ]),
    );
  }
}
