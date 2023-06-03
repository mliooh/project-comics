import 'package:flutter/material.dart';

class buttons extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const buttons({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: const Color(0xFF86808E),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
