import "package:flutter/material.dart";

import '../../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Login",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 20,
      ),
      const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail_outline),
          hintText: "email",
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.visibility_off),
          hintText: "password",
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Login with snapchat",
                style: TextStyle(color: Colors.black, fontSize: 17),
              )
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 252, 0),
              padding: const EdgeInsets.all(10),
              elevation: 0),
        ),
      ),
      const SizedBox(height: 10,)
,      ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.arrow_right)
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            padding: const EdgeInsets.all(10),
            elevation: 0),
      ),
      const SizedBox(
        height: 10,
      ),
      Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {},
            child: const Text("Already have an account?  Login"),
            style: TextButton.styleFrom(primary: kPrimaryColor),
          ))
    ]);
  }
}
