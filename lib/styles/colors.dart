// colors
import 'package:flutter/material.dart';

const Color kRichBlack = Color(0xFF000814);
const Color kCreamyOrange = Color(0xFFFFBF3D);
const Color kRipeOrange = Color(0xFFFF8D01);
const Color kSoftWhite = Color(0xFFF8F9FB);
const Color kDeepBlue = Color(0xFF200440);
const Color kGrey = Color(0xFFF6F6E8);

const kColorScheme = ColorScheme(
  primary: kRipeOrange,
  primaryContainer: kRipeOrange,
  secondary: kDeepBlue,
  secondaryContainer: kDeepBlue,
  surface: kCreamyOrange,
  background: kCreamyOrange,
  error: Colors.red,
  onPrimary: kSoftWhite,
  onSecondary: kSoftWhite,
  onSurface: kSoftWhite,
  onBackground: kGrey,
  onError: kGrey,
  brightness: Brightness.light,
);
