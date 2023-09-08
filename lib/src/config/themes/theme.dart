import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
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
          unselectedItemColor: Color.fromARGB(255, 68, 68, 68),
          elevation: 0),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: colorWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0)));

  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: colorBackgroundApp,
      useMaterial3: true,
      cardColor: colorCardView,
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
          backgroundColor: colorBackgroundApp,
          scrolledUnderElevation: 0,
          titleTextStyle:
              TextStyle(color: colorPinkButton, fontWeight: FontWeight.bold),
          elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 200, 34, 175),
          unselectedItemColor: Color.fromARGB(255, 68, 68, 68),
          elevation: 0),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: colorWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0)));
}