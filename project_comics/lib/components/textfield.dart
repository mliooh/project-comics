// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textField extends StatelessWidget {
  final String hintText;
  final bool obscuretext;
  final TextInputType textInputType;
  final TextEditingController controller;
  const textField(
      {super.key,
      required this.hintText,
      required this.obscuretext,
      required this.textInputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextField(
          controller: controller,
          obscureText: obscuretext,
          keyboardType: textInputType,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF0C4C45)),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF86808E))),
              fillColor: const Color(0xFF0C4C45),
              filled: true,
              hintText: hintText,
              hintStyle: GoogleFonts.josefinSans(color: Colors.white)),
        ));
  }
}
