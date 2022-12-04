import 'package:flutter/material.dart';

const Color primaryColor = Color(0XFF000000);
const Color secondaryColor = Color(0XFF2A966F);
const Color backgroundColor = Color(0XFFFFFFFF);
const Color foregroundColor = Color(0XFF41BA4D);
const Color processColor = Color(0XFFF4C01E);

ThemeData myTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: foregroundColor,
        onPrimary: backgroundColor,
        secondary: secondaryColor,
      ),
  scaffoldBackgroundColor: backgroundColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  iconTheme: const IconThemeData(color: secondaryColor, size: 20),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: foregroundColor,
    backgroundColor: foregroundColor,
    unselectedItemColor: primaryColor,
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: foregroundColor,
  //     minimumSize: const Size(100.0, 20.0),
  //   ),
  // ),
);
