import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_comics/authentication/signin_signup.dart';
import 'package:project_comics/pages/home_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // when user is logged in
            if (snapshot.hasData) {
              return const HomePage();
            }

            // when user is not logged in
            else {
              return const SignInSignUp();
            }
          }),
    );
  }
}
