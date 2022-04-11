import 'package:connect/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isUser;
  const MessageBubble({Key? key, required this.isUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 160,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: const Radius.circular(25), topRight: const Radius.circular(25), bottomLeft: isUser ? const Radius.circular(25): Radius.zero, bottomRight: isUser ?  Radius.zero : const Radius.circular(25) ),
            color: isUser ? shadePrimaryColor : Colors.grey[400]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("whatsup my gee", style: TextStyle(color: Colors.black, fontSize: 16),),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                children:  [const Text("1:23"), const SizedBox(width: 5,), if(isUser) const Icon(Icons.done_all, color: kPrimaryColor,size: 15)],
              )
            ],
          ),
        ),
      ],
    );
  }
}
