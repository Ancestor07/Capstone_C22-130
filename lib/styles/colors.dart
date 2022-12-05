// colors
import 'package:flutter/material.dart';

const Color kRichBlack = Color(0xFF000814);
const Color kCreamyOrange = Color(0xFFFFBF3D);
const Color kRipeOrange = Color(0xFFFF8D01);
const Color kSoftWhite = Color(0xFFF8F9FB);
const Color kDeepBlue = Color(0xFF200440);
const Color kGrey = Color(0xFFF6F6E8);

const kColorScheme = ColorScheme(
  primary: kCreamyOrange,
  primaryContainer: kCreamyOrange,
  secondary: kDeepBlue,
  secondaryContainer: kDeepBlue,
  surface: kRipeOrange,
  background: kRipeOrange,
  error: Colors.red,
  onPrimary: kRipeOrange,
  onSecondary: kSoftWhite,
  onSurface: kSoftWhite,
  onBackground: kGrey,
  onError: kGrey,
  brightness: Brightness.dark,
);
