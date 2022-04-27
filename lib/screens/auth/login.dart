import 'package:connect/providers/auth_provider.dart';
import 'package:connect/screens/auth/base_auth.dart';
import 'package:connect/screens/auth/signup.dart';
import 'package:connect/screens/home/chats_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/services.dart';
import '../add_user_details/add_user_detail.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  Widget _buildInputField(
      String hintText, Icon prefixIcon, TextEditingController controller,
      [Widget? suffixIcon]) {
    return TextField(
        controller: controller,
        keyboardType: hintText == 'email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: hintText == 'password' ? _obscureText : false,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
        ));
  }

  void _loginWithEmailAndPassword() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    showLoadingSpinner();
    final isLoggedIn = await context
        .read<AuthProvider>()
        .signIn(_emailController.text, _passwordController.text);
    Navigator.of(context).pop(); // pop loading spinner
    if (!isLoggedIn) {
      return;
    }
    Navigator.of(context).popAndPushNamed(
        ChatsScreen.routeName); // pop login and push home screen
  }

  void _loginWithGoogle() async {
    FocusScope.of(context).unfocus();
    final isLoggedIn = await context.read<AuthProvider>().signInWithGoogle();
    if (!isLoggedIn) {
      return; //not successful
    }
    if (context
            .read<AuthProvider>()
            .userCredential
            .additionalUserInfo
            ?.isNewUser ??
        false) {
      Navigator.of(context).popAndPushNamed(
          AddUserDetails.routeName); //if new gogle user show add detail screen
      return;
    }
    Navigator.of(context).popAndPushNamed(
        ChatsScreen.routeName); //if not new user push mf to the home screen
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAuthScreen(
        body: Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Login",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: kPrimaryColor)),
        const SizedBox(
          height: 20,
        ),
        _buildInputField('email', const Icon(Icons.email), _emailController),
        const SizedBox(
          height: 10,
        ),
        _buildInputField(
          'password',
          const Icon(Icons.lock),
          _passwordController,
          IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: _obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility)),
        ),
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ElevatedButton(
            onPressed: _loginWithGoogle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 25,
                    width: 50,
                    child: Image.asset("assets/images/google_logo.png")),
                const Text(
                  "continue with google",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                padding: const EdgeInsets.all(10),
                elevation: 0),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: _loginWithEmailAndPassword,
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
              onPressed: () {
                Navigator.of(context).popAndPushNamed(SignupScreen.routeName);
              },
              child: const Text("Don't have an account?  Sign up"),
              style: TextButton.styleFrom(primary: kPrimaryColor),
            ))
      ]),
    ));
  }
}
