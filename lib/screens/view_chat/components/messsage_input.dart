import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/models/message.dart';
import 'package:connect/utils/chat_helper.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/image_preview.dart';
import '../../../utils/constants.dart';

class MessageInput extends StatefulWidget {
  final String receiverId;
  const MessageInput({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
        source: source, maxWidth: 150, imageQuality: 80);
    if (image == null) {
      return;
    }
    File imageFile = File(image.path);
    if (source == ImageSource.gallery) {
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => ImagePreview(image: imageFile)))
          .then((value) {
        if (value) {
          ChatHelper.sendMessage('', 'image', widget.receiverId, imageFile);
        }
      });
    } else {
      ChatHelper.sendMessage('', 'image', widget.receiverId, imageFile);
    }
  }

  void sendMessage() async {
    if (_messageController.text.isEmpty) {
      return;
    }
    await ChatHelper.sendMessage(
      _messageController.text.trim(),
      'text',
      widget.receiverId,
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(25)),
        child: TextField(
          controller: _messageController,
          decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  showImageOptions(context, _pickImage);
                },
                icon: const Icon(
                  Icons.add,
                  color: kPrimaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.transparent)),
              suffixIcon: CircleAvatar(
                  radius: 20,
                  backgroundColor: shadePrimaryColor,
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                  ))),
        ),
      ),
    );
  }
}