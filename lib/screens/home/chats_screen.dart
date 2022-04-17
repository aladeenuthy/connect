import 'package:cached_network_image/cached_network_image.dart';

import 'package:connect/screens/home/components/user_chats.dart';
import 'package:connect/screens/home/components/users.dart';
import 'package:connect/screens/profile/profile_screen.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:connect/utils/constants.dart";


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);
  static const routeName = '/chats-screen';

  @override
  Widget build(BuildContext context) {

    final deviceHeight = getDeviceHeight(context);
    return Scaffold(
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: deviceHeight * 0.03,
            ),
            Container(
              height: deviceHeight * 0.23,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Connect",
                              style: Theme.of(context).textTheme.headline1!),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .popAndPushNamed(ProfileScreen.routeName);
                            },
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: shadePrimaryColor,
                                backgroundImage: CachedNetworkImageProvider(
                                    FirebaseAuth.instance.currentUser!.photoURL ??
                                        "")),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Users(size: constraints.maxHeight * 0.5)
                    ]);
              }),
            ),
            UserChats(deviceHeight: deviceHeight * 0.74)
          ]),
        ));
  }
}
