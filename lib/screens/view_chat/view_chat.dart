import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/screens/view_chat/components/messages.dart';
import 'package:connect/screens/view_chat/components/messsage_input.dart';
import 'package:connect/utils/chat_helper.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

class ViewChat extends StatefulWidget {
  final ChatUser receiver;
  const ViewChat({Key? key, required this.receiver}) : super(key: key);
  static const routeName = "/viewchat";

  @override
  State<ViewChat> createState() => _ViewChatState();
}

class _ViewChatState extends State<ViewChat> {
  @override
  void initState() {
    super.initState();
    ChatHelper.markLastMessageAsRead(getConvoId(
        FirebaseAuth.instance.currentUser!.uid, widget.receiver.userId));
  }

  AppBar appbar() {
    return AppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            width: 50,
          ),
          CircleAvatar(
              radius: 22,
              backgroundColor: shadePrimaryColor,
              backgroundImage:
                  CachedNetworkImageProvider(widget.receiver.profileUrl)),
          const SizedBox(
            width: 7,
          ),
          Text(widget.receiver.username,
              style: const TextStyle(
                  color: shadePrimaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight =
        getDeviceHeight(context) - appbar().preferredSize.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar(),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: deviceHeight,
              child: Column(children: [
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Messages(
                  size: deviceHeight,
                  receiver: widget.receiver,
                ),
                Expanded(
                    child: MessageInput(
                  receiverId: widget.receiver.userId,
                ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
