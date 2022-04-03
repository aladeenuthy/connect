import 'package:connect/screens/home/components/message.dart';
import 'package:flutter/material.dart';
import "package:connect/utils/constants.dart";

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Connect",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: shadePrimaryColor,
                            child: Icon(Icons.person_add, color: kPrimaryColor, size: 30,),
                          ),
                          SizedBox(width: 10,),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: shadePrimaryColor,
                            backgroundImage: AssetImage('assets/images/avatar_1.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: shadePrimaryColor,
                            backgroundImage: AssetImage('assets/images/avatar_4.png')
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: shadePrimaryColor,
                            backgroundImage:
                                  AssetImage('assets/images/avatar_5.png')
                          ),
                          SizedBox(width: 10,),
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
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 415,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              child: ListView(children: const [
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
              ]),
            )
          ]),
        ));
  }
}
