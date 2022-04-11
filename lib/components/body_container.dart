import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget bodyContent;
  final double size;
  const BodyContainer({Key? key, required this.bodyContent, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      height: size,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      child: bodyContent,
    );
  }
}
