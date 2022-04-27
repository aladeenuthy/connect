import 'package:connect/providers/auth_provider.dart';
import 'package:connect/screens/add_user_details/add_user_detail.dart';
import 'package:connect/screens/auth/base_auth.dart';
import 'package:connect/screens/auth/login.dart';
import 'package:connect/utils/constants.dart';
import 'package:connect/utils/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const routeName = '/signup-screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Map<String, String> _authData = {};

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  Widget _buildInputField(
      String hintText, String? Function(String?) validator, Icon prefixIcon,
      [Widget? suffixIcon]) {
    return TextFormField(
        validator: validator,
        onSaved: (value) {
          _authData[hintText] = value as String;
        },
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

  void _signUpWithEmailAndPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    showLoadingSpinner();
    final isSignedUP = await context
        .read<AuthProvider>()
        .signUpWithEmailAndPassword(
            _authData['email']!.trim(), _authData['password']!.trim(),);
    Navigator.of(context).pop(); // pop loading spinner
    if (!isSignedUP) {
      return; //not sucessful
    }
    Navigator.of(context)
        .popAndPushNamed(AddUserDetails.routeName); //successful
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();    
  }

  @override
  Widget build(BuildContext context) {
    return BaseAuthScreen(
        body: Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Sign Up",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: kPrimaryColor)),
        const SizedBox(
          height: 10,
        ),
        Form(
            key: _formKey,
            child: Column(
              children: [
                _buildInputField('email', (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                }, const Icon(Icons.email)),
                const SizedBox(
                  height: 10,
                ),
                _buildInputField(
                  'password',
                  (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  const Icon(Icons.lock),
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
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: _signUpWithEmailAndPassword,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "create account",
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
              },
              child: const Text("Already have an account?  Login"),
              style: TextButton.styleFrom(primary: kPrimaryColor),
            ))
      ]),
    ));
  }
}
