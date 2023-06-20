import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData themeData = ThemeData.light().copyWith(
    scaffoldBackgroundColor: colorGrey.shade100,
    useMaterial3: true,
    textTheme: GoogleFonts.nunitoTextTheme(),
    appBarTheme: AppBarTheme(
        backgroundColor: colorGrey.shade100,
        scrolledUnderElevation: 0,
        titleTextStyle: const TextStyle(
            color: colorPinkButton, fontWeight: FontWeight.bold),
        elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color.fromARGB(255, 200, 34, 175),
      unselectedItemColor: Color.fromARGB(255, 68, 68, 68),elevation: 0
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: colorWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0)));
