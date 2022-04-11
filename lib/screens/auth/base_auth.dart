import 'package:connect/utils/constants.dart';
import 'package:flutter/material.dart';

class BaseAuthScreen extends StatelessWidget {
  final Widget body;
  const BaseAuthScreen({Key? key, required this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse:  true,
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
                      Text(
                      "connect",
                      style: Theme.of(context).textTheme.headline1!.copyWith(color: kPrimaryColor),
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
