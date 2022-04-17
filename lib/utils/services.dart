import 'package:connect/utils/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top;
}

Future<bool> isConnectedToInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

void showLoadingSpinner(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: const [
        CircularProgressIndicator(color: kPrimaryColor),
        SizedBox(width: 10),
        Text("Loading"),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alert;
    },
  );
}

void showSnackBar(String message, BuildContext context, [bool error = true]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: error ? Colors.redAccent : Colors.greenAccent,
  ));
}

bool isMe(String id, String userId) {
  return id == userId;
}

String getConvoId(String id1, id2) {
  if (id1.hashCode <= id2.hashCode) {
    return '$id1-$id2';
  }
  return '$id2-$id1';
}

void showImageOptions(
    BuildContext context, Function imageCallBack) {
  AlertDialog alert = AlertDialog(
    content: SizedBox(
      height: 130,
      child: Column(children: [
        ListTile(
            leading: const Icon(
              Icons.camera,
              color: kPrimaryColor,
            ),
            title: const Text(
              "Camera",
              style: TextStyle(color: kPrimaryColor, fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pop();
              imageCallBack(ImageSource.camera);
            }),
        const Divider(
          color: kPrimaryColor,
        ),
        ListTile(
            leading: const Icon(Icons.photo_album, color: kPrimaryColor),
            title: const Text(
              "Gallery",
              style: TextStyle(color: kPrimaryColor, fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pop();
              imageCallBack(ImageSource.gallery);
            })
      ]),
    ),
  );
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return alert;
    },
  );
}
