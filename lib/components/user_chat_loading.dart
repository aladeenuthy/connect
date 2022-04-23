import 'package:connect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class UserChatLoading extends StatelessWidget {
  const UserChatLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 80,
      child: Shimmer.fromColors(
        child:  Row(children: [
            const CircleAvatar(
              radius: 40,
            ),
            const SizedBox(
              width: 7,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const SizedBox(height: 20,),
                Container(
                  color: shadePrimaryColor,
                  height: 10,
                  width: 200
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  color: shadePrimaryColor,
                  height: 10,
                  width: 170
                )
              ],
            )
          ]), baseColor: shadePrimaryColor, highlightColor: kPrimaryColor),
    );
  }
}