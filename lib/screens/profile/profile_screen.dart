import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/screens/home/chats_screen.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../auth/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final deviceHeight = getDeviceHeight(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.home,
          color: kPrimaryColor,
        ),
        splashColor: kPrimaryColor,
        backgroundColor: shadePrimaryColor,
        onPressed: () {
          Navigator.of(context).popAndPushNamed(ChatsScreen.routeName);
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight * 0.2,
            ),
            Stack(
              children: [
                CircleAvatar(
                    radius: 65,
                    backgroundColor: shadePrimaryColor,
                    backgroundImage: CachedNetworkImageProvider(
                        FirebaseAuth.instance.currentUser?.photoURL ?? "")),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            color: kPrimaryColor,
                          ),
                        )))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(FirebaseAuth.instance.currentUser?.displayName ?? "",
                style: const TextStyle(
                    color: shadePrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: shadePrimaryColor),
                onPressed: () async {
                  final isLoggedOut =
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signOut(context);
                  if (!isLoggedOut) {
                    return;
                  }
                  Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
                },
                child: const Text(
                  "Sign out",
                  style: TextStyle(color: kPrimaryColor, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
