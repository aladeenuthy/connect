import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final File image;
  const ImagePreview({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).pop(true);
        }, icon: const Icon(Icons.done))],
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.file(image, fit: BoxFit.cover, filterQuality: FilterQuality.high ,),
        ),
      ),
    );
  }
}
