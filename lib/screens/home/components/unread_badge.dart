import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class UnreadBadge extends StatelessWidget {
  final String count;
  const UnreadBadge({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(count, style: const TextStyle(color: shadePrimaryColor),)
      );
  }
}
