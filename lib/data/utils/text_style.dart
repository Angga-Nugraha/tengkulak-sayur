// text style
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle kHeading5 =
    GoogleFonts.firaSans(fontSize: 18, fontWeight: FontWeight.bold);
final TextStyle kHeading6 = GoogleFonts.firaSans(
    fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.firaSans(
    fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.firaSans(
    fontSize: 8, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);
