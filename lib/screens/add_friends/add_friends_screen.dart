import 'package:connect/components/body_container.dart';
import 'package:connect/screens/add_friends/components/user_search_result.dart';
import 'package:connect/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../utils/services.dart';
class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({ Key? key }) : super(key: key);

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  
  @override
  Widget build(BuildContext context) {
    final deviceHeight = getDeviceHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          SizedBox(height: deviceHeight * 0.03,),
          Container(
            height: deviceHeight * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text('Add Friends', style: Theme.of(context)
                        .textTheme
                        .headline1!),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      borderSide:  const BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.transparent)),
                      hintText: "search user",
                      suffixIcon: CircleAvatar(
                        radius: 20,
                        backgroundColor: shadePrimaryColor,
                        child: IconButton(onPressed: (){}, icon: const Icon(Icons.search, color: kPrimaryColor,),))
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          BodyContainer(size: deviceHeight * 0.77,bodyContent: ListView(children: const [
            UserSearchResult(user: "Abdul", imageUrl: "assets/images/avatar_5.png"),
            UserSearchResult(
                  user: "Aladeen", imageUrl: "")
          ],))
        ]),
      ),
    );
  }
}