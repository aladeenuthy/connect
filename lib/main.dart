import 'package:connect/models/models.dart';
import 'package:connect/providers/auth_provider.dart';
import 'package:connect/screens/add_friends/add_friends_screen.dart';
import 'package:connect/screens/add_user_details/add_user_detail.dart';
import 'package:connect/screens/auth/login.dart';
import 'package:connect/screens/auth/signup.dart';
import 'package:connect/screens/home/chats_screen.dart';
import 'package:connect/screens/profile/profile_screen.dart';
import 'package:connect/screens/view_chat/view_chat.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/helpers/key_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(appId);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: KeyHelper.navKey,
        scaffoldMessengerKey: KeyHelper.scafKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: kPrimaryColor,
            primaryColor: kPrimaryColor,
            textTheme: ThemeData.light().textTheme.copyWith(
                headline1: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: kPrimaryColor),
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    borderSide: const BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2)))),
        home: FirebaseAuth.instance.currentUser != null
            ? const ChatsScreen()
            : const LoginScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == ViewChat.routeName) {
            final value = settings.arguments as ChatUser;
            return MaterialPageRoute(
                settings: settings,
                builder: (ctx) => ViewChat(receiver: value));
          } else if (settings.name == AddFriendsScreen.routeName) {
            return MaterialPageRoute(
                settings: settings, builder: (ctx) => const AddFriendsScreen());
          } else if (settings.name == AddUserDetails.routeName) {
            return MaterialPageRoute(
                settings: settings, builder: (ctx) => const AddUserDetails());
          } else if (settings.name == LoginScreen.routeName) {
            return MaterialPageRoute(
                settings: settings, builder: (ctx) => const LoginScreen());
          } else if (settings.name == SignupScreen.routeName) {
            return MaterialPageRoute(
                settings: settings, builder: (ctx) => const SignupScreen());
          } else if (settings.name == ProfileScreen.routeName) {
            return MaterialPageRoute(
                settings: settings, builder: (ctx) => const ProfileScreen());
          }
          return MaterialPageRoute(
              settings: settings, builder: (ctx) => const ChatsScreen());
        },
      ),
    );
  }
}
