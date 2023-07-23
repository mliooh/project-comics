import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_comics/components/buttons.dart';
import 'package:project_comics/components/textfield.dart';
import 'package:project_comics/pages/collections.dart';
import 'package:project_comics/pages/signin.dart';

import '../authentication/auth_service.dart';

class signUp extends StatefulWidget {
  const signUp({
    super.key,
  });

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  // text editing controller
  final AuthService _auth = AuthService();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  Future<void> _signUp() async {
    String email = emailTextController.text;
    String password = passwordTextController.text;
    User? user = await _auth.registerWithEmailAndPassword(email, password);

    if (user != null) {
      // Navigate to the home screen or other authenticated pages
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      // Show an error message or do something else if sign-up fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF03302B),
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          // salutation

                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "New Here?",
                                  style: GoogleFonts.josefinSans(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Create an Account",
                                  style: GoogleFonts.josefinSans(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 45),

                          // email input field

                          textField(
                            hintText: "Enter your email",
                            controller: emailTextController,
                            obscuretext: false,
                            textInputType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 20),

                          //password input Field

                          textField(
                            hintText: "Password",
                            controller: passwordTextController,
                            obscuretext: true,
                            textInputType: TextInputType.visiblePassword,
                          ),

                          const SizedBox(height: 20),

                          // confirm password

                          textField(
                            hintText: "Confirm Password",
                            controller: confirmPasswordTextController,
                            obscuretext: true,
                            textInputType: TextInputType.visiblePassword,
                          ),

                          const SizedBox(height: 20),

                          Buttons(text: "SignUp", onTap: _signUp),
                          const SizedBox(
                            height: 40,
                          ),

                          // or continue with

                          Text(
                            'or continue with',
                            style: GoogleFonts.josefinSans(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF0C4C45),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      "lib/images/logo.png",
                                      scale: 20,
                                    ),
                                  ),

                                  const SizedBox(width: 30),

                                  // apple signup button

                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF0C4C45),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      "lib/images/applelogo.png",
                                      height: 20,
                                    ),
                                  ),
                                ]),
                          ),

                          const SizedBox(height: 60),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already a Member?",
                                style: GoogleFonts.josefinSans(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => signin())));
                                },
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.josefinSans(
                                      fontStyle: FontStyle.italic,
                                      color: const Color(0xFF86808E),
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ]))))));
  }
}
