import 'package:flutter/material.dart';
import 'package:friendzone/src/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_schemes.g.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    shadowColor: lightColorScheme.shadow,
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
    appBarTheme: _appBarTheme,
    searchBarTheme: SearchBarThemeData(
      elevation: MaterialStateProperty.all(0.0),
    ),
    bottomNavigationBarTheme: _bottomNavBarTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    shadowColor: lightColorScheme.shadow,
    textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
    appBarTheme: _appBarTheme,
    bottomNavigationBarTheme: _bottomNavBarTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0),
    ),
  );
}

const _bottomNavBarTheme = BottomNavigationBarThemeData(
  selectedItemColor: Color.fromARGB(255, 200, 34, 175),
  unselectedItemColor: Color.fromARGB(255, 68, 68, 68),
  elevation: 0,
);
const _appBarTheme = AppBarTheme(
  scrolledUnderElevation: 0,
  titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
  elevation: 0,
);
