import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/screens/view_chat/components/messages.dart';
import 'package:connect/screens/view_chat/components/messsage_input.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/utils/services.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

class ViewChat extends StatelessWidget {
  final ChatUser receiver;
  const ViewChat({Key? key, required this.receiver}) : super(key: key);
  static const routeName = "/viewchat";


  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
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
                  CachedNetworkImageProvider(receiver.profileUrl)),
          const SizedBox(
            width: 7,
          ),
          Text(receiver.username,
              style: const TextStyle(
                  color: shadePrimaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    final deviceHeight =
        getDeviceHeight(context) - appBar.preferredSize.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar,
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
                  receiver: receiver,
                ),
                Expanded(
                    child: MessageInput(
                  receiver: receiver,
                ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
