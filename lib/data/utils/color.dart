import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/utils/text_style.dart';

const Color primaryColor = Color(0XFF000000);
const Color secondaryColor = Color(0XFF2A966F);
const Color backgroundColor = Color(0XFFFFFFFF);
const Color foregroundColor = Color(0XFF41BA4D);
const Color processColor = Color(0XFFF4C01E);

ThemeData myTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: secondaryColor,
      ),
  textTheme: kTextTheme,
  scaffoldBackgroundColor: backgroundColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: foregroundColor),
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
  ),
);
