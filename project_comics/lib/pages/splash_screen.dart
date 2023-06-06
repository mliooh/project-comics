import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:project_comics/authentication/signin_signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TO DO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 20), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const signinSignup(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'lib/images/ultimatecomics.png',
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}
