import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData themeData = ThemeData.light().copyWith(
    useMaterial3: true,
    textTheme: GoogleFonts.nunitoTextTheme(),
    appBarTheme: const AppBarTheme(
        titleTextStyle:
            TextStyle(color: colorPinkButton, fontWeight: FontWeight.bold),
        elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color.fromARGB(255, 200, 34, 175),
      unselectedItemColor: Color.fromARGB(255, 68, 68, 68),
    ));
