import 'package:flutter/material.dart';
import 'package:project_comics/pages/signin.dart';
import 'package:project_comics/pages/signup.dart';

class signinSignup extends StatefulWidget {
  const signinSignup({super.key});

  @override
  State<signinSignup> createState() => _signinSignupState();
}

class _signinSignupState extends State<signinSignup> {
  //show the signin page
  bool showsignin = true;

  void togglepages() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin) {
      return signin(onTap: togglepages);
    } else {
      return signup(onTap: togglepages);
    }
  }
}
