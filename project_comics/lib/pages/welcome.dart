import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_comics/components/buttons.dart';
import 'package:project_comics/pages/splash_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({
    super.key,
  });

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'lib/images/ultimatecomics.png',
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 350,
                child: Image.asset(
                  'lib/images/ultimatecomics.png',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to Ultimate comics",
                    style: GoogleFonts.josefinSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                "Discover a world of captivating        \n      comics at your fingertips.",
                style: GoogleFonts.josefinSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF86808E),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Immerse yourself in thrilling  stories \n and stunning artwork.",
                style: GoogleFonts.josefinSans(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF86808E),
                ),
              ),

              const SizedBox(height: 40),

              // get started

              buttons(text: 'Get started', onTap: () {}),
              const SizedBox(
                height: 20,
              ),

              //signin

              buttons(
                  text: 'SignIn',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()));
                  })
            ],
          ),
        ));
  }
}
