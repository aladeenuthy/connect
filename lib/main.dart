import 'package:connect/components/res.dart';
import 'package:connect/providers/auth_provider.dart';
import 'package:connect/screens/add_friends/add_friends_screen.dart';
import 'package:connect/screens/add_user_details/add_user_detail.dart';
import 'package:connect/screens/auth/base_auth.dart';
import 'package:connect/screens/auth/login.dart';
import 'package:connect/screens/auth/signup.dart';
import 'package:connect/screens/home/chats_screen.dart';
import 'package:connect/screens/profile/profile_screen.dart';
import 'package:connect/screens/view_chat/view_chat.dart';
import 'package:connect/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: kPrimaryColor,
          primaryColor: kPrimaryColor, 
          textTheme: ThemeData.light().textTheme.copyWith(
            headline1: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: kPrimaryColor),
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
                        const BorderSide(color: kPrimaryColor, width: 2)))
        ),
        home:  FirebaseAuth.instance.currentUser != null
            ? const ChatsScreen()
            : const LoginScreen(),
        routes: {
          ProfileScreen.routeName: (_) => const ProfileScreen(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          SignupScreen.routeName: (_) => const SignupScreen(),
          AddUserDetails.routeName: (_) => const AddUserDetails(),
          ChatsScreen.routeName: (_) => const ChatsScreen()
        },
      ),
    );
  }
}

