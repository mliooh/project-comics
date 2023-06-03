import 'package:flutter/material.dart';
import 'package:project_comics/authentication/signin_signup.dart';
import 'package:project_comics/pages/splash_screen.dart';

import 'pages/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
