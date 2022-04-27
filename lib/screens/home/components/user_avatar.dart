import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../utils/constants.dart';
import '../../view_chat/view_chat.dart';

class UserAvatar extends StatelessWidget {
  final ChatUser user;
  const UserAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ViewChat.routeName, arguments: user);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: CircleAvatar(
            radius: 30,
            backgroundColor: shadePrimaryColor,
            backgroundImage: CachedNetworkImageProvider(user.profileUrl),
          ),
      ),
    );
  }
}
