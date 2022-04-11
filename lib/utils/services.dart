import 'package:connect/utils/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

double getDeviceHeight(BuildContext context){
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
void showImageOptions(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Column(children: [
      GestureDetector(
        child: const Text("Camera", style: TextStyle(
          color: kPrimaryColor,
          fontSize: 17
        ),),
      ),
      const Divider(color: kPrimaryColor,thickness: 3,),
      GestureDetector(
        child: const Text(
          "Gallery",
          style: TextStyle(color: kPrimaryColor, fontSize: 17),
        ),
      ),
    ]),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alert;
    },
  );
}
void showSnackBar(String message , BuildContext context, [bool error = true]){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.redAccent: Colors.greenAccent,
      ));
}

/*
File? _pickedImage;
void _pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final image = await _picker.pickImage(
      source: ImageSource.camera, maxWidth: 150, imageQuality: 50);
  if (image == null) {
    return;
  }
  File imageFile = File(image.path);
  setState(() {
    _pickedImage = imageFile;
  });
  widget.submitImage(imageFile);
}


final ref = FirebaseStorage.instance
            .ref()
            .child('profile_pics')
            .child(_authResult.user!.uid + ".jpg");
        await ref.putFile(image);
        final url = await ref.getDownloadURL();
 */
