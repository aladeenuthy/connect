import 'package:connect/components/body_container.dart';
import 'package:connect/screens/view_chat/components/message_bubble.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/utils/services.dart';
import 'package:flutter/material.dart';

class ViewChat extends StatefulWidget {
  const ViewChat({Key? key}) : super(key: key);

  @override
  State<ViewChat> createState() => _ViewChatState();
}

class _ViewChatState extends State<ViewChat> {
  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: shadePrimaryColor,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: 1,
          ),
          const CircleAvatar(
              radius: 22,
              backgroundColor: shadePrimaryColor,
              backgroundImage: AssetImage('assets/images/avatar_5.png')),
          const SizedBox(
            width: 7,
          ),
          const Text("giggs",
              style: TextStyle(
                  color: shadePrimaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    final deviceHeight =
        getDeviceHeight(context) - _appBar.preferredSize.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(children: [
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              BodyContainer(
                  size: deviceHeight * 0.87,
                  bodyContent: ListView(
                    reverse: true,
                    children: const [
                      MessageBubble(isUser: true),
                      MessageBubble(isUser: false),
                      MessageBubble(isUser: true),
                      MessageBubble(isUser: true),
                      MessageBubble(isUser: false),
                      MessageBubble(isUser: true),
                      MessageBubble(isUser: true),
                      MessageBubble(isUser: false),
                      MessageBubble(isUser: true)
                    ],
                  )),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25)),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            print("alhamdulilah");
                            FocusScope.of(context).unfocus();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: kPrimaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        suffixIcon: CircleAvatar(
                            radius: 20,
                            backgroundColor: shadePrimaryColor,
                            child: IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: kPrimaryColor,
                              ),
                            ))),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
