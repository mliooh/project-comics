// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:project_comics/components/buttons.dart';
import 'package:google_fonts/google_fonts.dart';

class test extends StatefulWidget {
  const test({
    super.key,
  });

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03302B),
      body: SafeArea(
        /*--------------------------------------------image-----------------------------------------*/

        child: Padding(
          padding: const EdgeInsets.only(bottom: 90.0, top: 120, left: 15),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                /*mainAxisAlignment: MainAxisAlignment.center,*/
                children: [
                  /*---------------------------------------Welcome to Ultimate Comics, where imagination comes to life---------------------------------------*/

                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Welcome to Ultimate Comics,',
                      style: GoogleFonts.josefinSans(fontSize: 47),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                      'Where imagination comes to life. Dive into an exciting world of heroes and villains!',
                      style: GoogleFonts.josefinSans(fontSize: 24)),
                  const Spacer(),

                  /*---------------------------------------------------------Get Started----------------------------------------------*/

                  Buttons(
                    onTap: () {},
                    text: 'Get Started',
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /*---------------------------------------------------Login In----------------------------------------------------*/

                  Buttons(
                    onTap: () {},
                    text: 'SignIn',
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
