import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class Message extends StatelessWidget {
  final String imageUrl;
  final String user;
  const Message({Key? key, required this.imageUrl, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 70,
      width: double.infinity,
      child: Row(children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: shadePrimaryColor,
          backgroundImage: AssetImage(
            imageUrl,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(user,
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 4,
            ),
            const Text("it's all good man",
                style: TextStyle(
                  color: shadePrimaryColor,
                  fontSize: 16,
                ))
          ],
        ),
        const Spacer(),
        Column(
          children: const [
            Text("12:30",
                style: TextStyle(
                  color: shadePrimaryColor,
                  fontSize: 14,
                )),
            SizedBox(
              height: 10,
            ),
            Text("2")
          ],
        )
      ]),
    );
  }
}
