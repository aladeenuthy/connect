import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/screens/home/components/user_chat.dart';
import 'package:connect/helpers/chat_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/body_container.dart';
import '../../../models/message.dart';
import '../../../utils/services.dart';

class UserChats extends StatelessWidget {
  final double deviceHeight;
  const UserChats({Key? key, required this.deviceHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyContainer(
        size: deviceHeight,
        bodyContent: StreamBuilder<QuerySnapshot<Message>>(
          stream: ChatHelper.getLastMessages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Container();
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    return UserChat(
                        isUser: isMe(snapshot.data!.docs[index].data().senderId,
                            FirebaseAuth.instance.currentUser!.uid),
                        message: snapshot.data!.docs[index].data());
                  });
            } else {
              return Container();
            }
          },
        ));
  }
}
