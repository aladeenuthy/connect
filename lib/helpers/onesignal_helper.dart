import 'package:connect/helpers/key_helper.dart';
import 'package:connect/models/models.dart';
import 'package:connect/screens/home/chats_screen.dart';
import 'package:connect/screens/view_chat/view_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalHelper {
  static Future<void> initialize() async {
    // will be called when notification is received in foreground
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      Route? routeSettings;

      
      //to get current routename
      KeyHelper.navKey.currentState!.popUntil(
        (route) {
          routeSettings = route;
          return true;
        },
      );


      // if user is in chatscreen or user is not authenticated do not show notifications
      if (routeSettings!.settings.name == ChatsScreen.routeName ||
          FirebaseAuth.instance.currentUser == null) {
        event.complete(null); //  do not show notifications
        return;
      }
      // if user is already in chat of the notification sender  do not show notifications
      ChatUser user = routeSettings!.settings.arguments as ChatUser;
      if (routeSettings!.settings.name == ViewChat.routeName &&
          event.notification.title == user.username) {
        event.complete(null); //  do not show notifications
        return;
      }
      event.complete(event.notification);
    });
    // called whern notification is clicked
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      
      // pop mf out to home screen and push mf to the chat
      KeyHelper.navKey.currentState!
          .popUntil((ModalRoute.withName(ChatsScreen.routeName)));
      KeyHelper.navKey.currentState!.pushNamed(ViewChat.routeName,
          arguments: ChatUser.fromFirestore(
              result.notification.additionalData as Map<String, dynamic>));
    });
  }

  static Future<String?> deviceToken() async {
    final deviceState = await OneSignal.shared.getDeviceState();
    return deviceState!.userId;
  }

  static Future<void> sendPushNotification(
      {required String content,
      required String receiverDeviceToken,
      required Map<String, String> userData,
      required String bigPicture}) async {
    final notification = OSCreateNotification(
        additionalData: userData,
        playerIds: [receiverDeviceToken],
        bigPicture: bigPicture.isEmpty ? null : bigPicture,
        content: content,
        heading: userData['username'],
        androidLargeIcon:
            'https://www.filepicker.io/api/file/6LfG3qRbSmqwZUF3z83K?filename=name.png');
    await OneSignal.shared.postNotification(notification);
  }
}
