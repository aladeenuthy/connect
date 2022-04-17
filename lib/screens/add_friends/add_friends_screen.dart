import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/components/body_container.dart';
import 'package:connect/screens/add_friends/components/user_search_result.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/utils/user_helper.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../utils/services.dart';
import '../view_chat/view_chat.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({Key? key}) : super(key: key);
  static const routeName = "/add-friends";

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  Future<QuerySnapshot<ChatUser>>? _future;
  final queryController = TextEditingController();
  final _appBar = AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight =
        getDeviceHeight(context) - _appBar.preferredSize.height;
    return SafeArea(
      child: Scaffold(
        appBar: _appBar,
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          SizedBox(
            height: deviceHeight * 0.03,
          ),
          Container(
            height: deviceHeight * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Friends',
                    style: Theme.of(context).textTheme.headline1!),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextField(
                    controller: queryController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        hintText: "search user",
                        suffixIcon: CircleAvatar(
                            radius: 20,
                            backgroundColor: shadePrimaryColor,
                            child: IconButton(
                              onPressed: () {
                                if (queryController.text.isEmpty) {
                                  return;
                                }
                                setState(() {
                                  _future = UserHelper.queryUsers(
                                      queryController.text.trim());
                                });
                              },
                              icon: const Icon(
                                Icons.search,
                                color: kPrimaryColor,
                              ),
                            ))),
                  ),
                ),
              ],
            ),
          ),
          BodyContainer(
              size: deviceHeight * 0.77,
              bodyContent: _future == null
                  ? Container()
                  : FutureBuilder(
                      future: _future,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<ChatUser>?> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ViewChat(
                                                  receiver: snapshot
                                                      .data!.docs[index]
                                                      .data(),
                                                )));
                                  },
                                  child: UserSearchResult(
                                    user: snapshot.data!.docs[index].data(),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: Text("no results found"),
                          );
                        }
                      },
                    ))
        ]),
      ),
    );
  }
}
