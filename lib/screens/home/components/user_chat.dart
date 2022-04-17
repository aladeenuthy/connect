import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/screens/home/components/unread_badge.dart';
import 'package:connect/utils/helpers.dart';
import 'package:connect/utils/services.dart';
import 'package:connect/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../view_chat/view_chat.dart';

class UserChat extends StatefulWidget {
  final bool isUser;
  final Message message;
  const UserChat({Key? key, required this.isUser,  required this.message}) : super(key: key);

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  late Future<ChatUser> _future;
  
  @override
  void initState() {
    super.initState();
    
    _future = UserHelper.getUser(
        widget.isUser ? widget.message.receiverId : widget.message.senderId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<ChatUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewChat(
                          receiver: snapshot.data!,
                        )));
              },
              child: Container(
                
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 70,
                width: double.infinity,
                child: Row(children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: shadePrimaryColor,
                    backgroundImage:
                        CachedNetworkImageProvider(snapshot.data!.profileUrl),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.username,
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          if (widget.isUser)
                            Icon(
                                widget.message.isRead
                                    ? Icons.done_all
                                    : Icons.done,
                                color: kPrimaryColor,
                                size: 15),
                          const SizedBox(
                            width: 5,
                          ),
                        widget.message.contentType == 'text' ? Text(
                              widget.message.content.length > 20
                                  ? widget.message.content.substring(0, 10) +
                                      "..."
                                  : widget.message.content,
                              style: const TextStyle(
                                color: shadePrimaryColor,
                                fontSize: 16,
                              )): const Icon(Icons.photo_album, color: kPrimaryColor, size: 20,),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("12:30",
                          style: TextStyle(
                            color: shadePrimaryColor,
                            fontSize: 14,
                          )),
                      if (widget.message.receiverId ==
                              FirebaseAuth.instance.currentUser!.uid &&
                          !widget.message.isRead)
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: ChatHelper.numberOfUnread(getConvoId(
                                FirebaseAuth.instance.currentUser!.uid,
                                snapshot.data!.userId)),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return UnreadBadge(
                                    count:
                                        snapshot.data!.docs.length.toString());
                              } else {
                                return const Text("");
                              }
                            })
                    ],
                  )
                ]),
              ),
            );
          }
          return Container();
        });
  }
}
