import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class UserSearchResult extends StatelessWidget {
  final String user;
  final String imageUrl;
  const UserSearchResult({Key? key, required this.user, required this.imageUrl}) : super(key: key);

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
          backgroundImage: imageUrl.isNotEmpty ? AssetImage(
            imageUrl,
          ):null,
          child: imageUrl.isEmpty ? const Icon(Icons.person, color: kPrimaryColor, size: 30,): null ,
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user,
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 4,
            ),
            const Text("@aladeen_uthy",
                style: TextStyle(
                  color: shadePrimaryColor,
                  fontSize: 16,
                ))
          ],
        ),
      ]),
    );
  }
}
