/*import 'package:flutter/material.dart';
import 'package:project_comics/pages/signin.dart';
import 'package:project_comics/pages/signup.dart';

class SignInSignUp extends StatefulWidget {
  const SignInSignUp({super.key});

  @override
  State<SignInSignUp> createState() => _SignInSignUpState();
}

class _SignInSignUpState extends State<SignInSignUp> {
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
      return signUp(onTap: togglepages);
    }
  }
}
*/