import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final primaryColor = Colors.blue[700];

final ThemeData mainTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColorBrightness: Brightness.dark,
  primaryColor: primaryColor,
  accentColor: Colors.blueAccent,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData(
      brightness: Brightness.dark,
    ).textTheme,
  ).copyWith(
      headline6: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  )),
);
