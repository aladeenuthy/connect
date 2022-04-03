import 'package:connect/screens/auth/base_auth.dart';
import 'package:connect/screens/auth/signup.dart';
import 'package:connect/screens/home/chats_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primaryColor: Colors.black, colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.black),
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
                      const BorderSide(color: Colors.black, width: 2)))
      ),
      home: const ChatsScreen(),
    );
  }
}

