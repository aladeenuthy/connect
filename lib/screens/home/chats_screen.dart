import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/components/body_container.dart';
import 'package:connect/screens/auth/login.dart';
import 'package:connect/screens/auth/signup.dart';
import 'package:connect/screens/home/components/message.dart';
import 'package:connect/screens/profile/profile_screen.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:connect/utils/constants.dart";
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);
  static const routeName = '/chats-screen';

  @override
  Widget build(BuildContext context) {
    final deviceHeight = getDeviceHeight(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final isLoggedOut =
                  await Provider.of<AuthProvider>(context, listen: false)
                      .signOut(context);
              if (!isLoggedOut) {
                return;
              }
              Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
            },
            child: Text('lo')),
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: deviceHeight * 0.03,
            ),
            Container(
              height: deviceHeight * 0.25,
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
                                    FirebaseAuth
                                            .instance.currentUser?.photoURL ??
                                        "")),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: constraints.maxHeight * 0.5,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: shadePrimaryColor,
                              child: Icon(
                                Icons.person_add,
                                color: kPrimaryColor,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: shadePrimaryColor,
                              backgroundImage:
                                  AssetImage('assets/images/beast1.jpg'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: shadePrimaryColor,
                                backgroundImage:
                                    AssetImage('assets/images/armor1.jpg')),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: shadePrimaryColor,
                                backgroundImage:
                                    AssetImage('assets/images/pain.jpg')),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: shadePrimaryColor,
                              backgroundImage:
                                  AssetImage('assets/images/avatar_1.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: shadePrimaryColor,
                                backgroundImage:
                                    AssetImage('assets/images/avatar_4.png')),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: shadePrimaryColor,
                                backgroundImage:
                                    AssetImage('assets/images/avatar_5.png')),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: shadePrimaryColor,
                              backgroundImage:
                                  AssetImage('assets/images/avatar_1.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: shadePrimaryColor,
                                backgroundImage:
                                    AssetImage('assets/images/avatar_4.png')),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: shadePrimaryColor,
                                backgroundImage:
                                    AssetImage('assets/images/avatar_5.png')),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ]);
              }),
            ),
            BodyContainer(
                size: deviceHeight * 0.72,
                bodyContent: ListView(children: const [
                  Message(
                    imageUrl: 'assets/images/pain.jpg',
                    user: "jefferson",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_4.png',
                    user: "hauwa",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_5.png',
                    user: "giggs",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_1.png',
                    user: "jefferson",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_4.png',
                    user: "hauwa",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_5.png',
                    user: "giggs",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_1.png',
                    user: "jefferson",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_4.png',
                    user: "hauwa",
                  ),
                  Message(
                    imageUrl: 'assets/images/avatar_5.png',
                    user: "giggs",
                  ),
                ]))
          ]),
        ));
  }
}
