import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/utils/chat_helper.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/body_container.dart';
import 'package:connect/models/models.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  final double size;
  final ChatUser receiver;
  const Messages({Key? key, required this.size, required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final convoId = getConvoId(FirebaseAuth.instance.currentUser!.uid, receiver.userId);
    return BodyContainer(
        size: size * 0.87,
        bodyContent: StreamBuilder<QuerySnapshot<Message>>(
            stream: ChatHelper.getMessages(convoId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (snapshot.hasData) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => MessageBubble(
                        convoId: convoId,
                        message: snapshot.data!.docs[index].data()));
              } else {
                return Container();
              }
            }));
  }
}
