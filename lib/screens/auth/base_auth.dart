import 'package:connect/utils/constants.dart';
import 'package:flutter/material.dart';

class BaseAuthScreen extends StatelessWidget {
  final Widget body;
  const BaseAuthScreen({Key? key, required this.body}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('assets/images/logo2.png',
                        cacheHeight: 80, cacheWidth: 60),
                    const Text(
                      "connect",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: body)
            ],
          ),
        ));
  }
}
