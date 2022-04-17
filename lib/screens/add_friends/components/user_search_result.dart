import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect/models/user.dart';
import 'package:flutter/material.dart';


import '../../../utils/constants.dart';

class UserSearchResult extends StatelessWidget {
  final ChatUser user;
  const UserSearchResult({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 70,
      width: double.infinity,
      child: Row(children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: shadePrimaryColor,
          backgroundImage: CachedNetworkImageProvider(user.profileUrl)
        ),
        const SizedBox(
          width: 12,
        ),
        Text(user.username,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold))
      ]),
    );
  }
}
