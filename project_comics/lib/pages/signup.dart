import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_comics/components/buttons.dart';
import 'package:project_comics/components/textfield.dart';

class signup extends StatefulWidget {
  final Function()? onTap;
  const signup({super.key, required this.onTap});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
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
                          Text(
                            "Create an Account",
                            style: GoogleFonts.josefinSans(
                                fontStyle: FontStyle.italic,
                                fontSize: 26,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 45),

                          // email input field

                          const textField(
                            hintText: "Enter your email",
                            obscuretext: false,
                            textInputType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 20),

                          //password input Field

                          const textField(
                            hintText: "Password",
                            obscuretext: true,
                            textInputType: TextInputType.visiblePassword,
                          ),

                          const SizedBox(height: 20),

                          // confirm password

                          const textField(
                            hintText: "Confirm Password",
                            obscuretext: true,
                            textInputType: TextInputType.visiblePassword,
                          ),

                          const SizedBox(height: 20),

                          buttons(text: "SignUp", onTap: () {}),
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
                                      scale: 5,
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
                                onTap: widget.onTap,
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
