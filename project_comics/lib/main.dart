import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_comics/authentication/auth_service.dart';
import 'package:project_comics/components/connectivity_wrapper.dart';
import 'package:project_comics/firebase_options.dart';

import 'package:project_comics/pages/homepage.dart';
import 'package:project_comics/pages/signin.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectivityWrapper(
        child: StreamBuilder(
          stream: AuthService().authStateChanges,
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;

              if (user == null) {
                // User is not logged in
                return signin();
              } else {
                // User is logged in
                return Homepage();
              }
            } else {
              // Show a loading indicator or splash screen while waiting for the authentication state to be determined
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }
}
