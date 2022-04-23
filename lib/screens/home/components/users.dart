import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/screens/home/components/user_avatar.dart';
import 'package:connect/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import '../../../models/user.dart';
import '../../../utils/constants.dart';
import '../../add_friends/add_friends_screen.dart';

class Users extends StatelessWidget {
  final double size;
  const Users({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size,
      child: StreamBuilder<QuerySnapshot<ChatUser>>(
        stream: UserHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddFriendsScreen.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: shadePrimaryColor,
                      child: Icon(
                        Icons.person_add,
                        color: kPrimaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, index) {
                      return UserAvatar(
                        user: snapshot.data!.docs[index].data(),
                      );
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
