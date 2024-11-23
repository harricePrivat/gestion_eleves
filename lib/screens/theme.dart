import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final appTheme = ThemeData(
      primaryColor: const Color.fromRGBO(255,0,0,0),
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
              fontSize: 45,
              fontWeight: FontWeight.w800,
              foreground: Paint()
                ..shader = const LinearGradient(colors: <Color>[
                  Color.fromRGBO(240, 46, 46, 0.8),
                  Color.fromRGBO(236, 107, 107, 0.898),
                ]).createShader(const Rect.fromLTWH(0, 0, 200, 70))),
          titleLarge:
              GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 22),
          bodyLarge: GoogleFonts.lato(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600),
          bodyMedium: GoogleFonts.lato(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.w500),
          displayMedium: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 116, 115, 115),
          ),
          displaySmall: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 0, 0, 0),
          )));
}
