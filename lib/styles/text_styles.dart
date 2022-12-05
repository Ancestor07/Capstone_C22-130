import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngawasi/styles/colors.dart';

final kTextTheme = TextTheme(
  headline1: GoogleFonts.merriweatherSans(
      fontSize: 91, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.merriweatherSans(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.merriweatherSans(fontSize: 45, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.merriweatherSans(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
      GoogleFonts.merriweatherSans(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.merriweatherSans(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.merriweatherSans(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.merriweatherSans(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.openSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.openSans(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
).apply(
  bodyColor: kDeepBlue,
  displayColor: kRipeOrange,
);
