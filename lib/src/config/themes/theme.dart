import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: colorGrey.shade100,
      shadowColor: colorGrey.shade300,
      iconTheme: IconThemeData(color: colorBlack.withOpacity(0.6)),
      textTheme: GoogleFonts.nunitoTextTheme(),
      appBarTheme: _appBarThemeLight,
      searchBarTheme:
          SearchBarThemeData(elevation: MaterialStateProperty.all(0.0)),
      drawerTheme: DrawerThemeData(backgroundColor: colorGrey.shade100 ),
      bottomNavigationBarTheme: _bottomNavBarTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: colorWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0)));

  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: colorBackgroundApp,
      cardColor: colorCardView,
      shadowColor: colorGrey.shade800,
      iconTheme: const IconThemeData(color: colorWhite),
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
      appBarTheme: _appBarThemeDark,
      bottomNavigationBarTheme: _bottomNavBarTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: colorWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0)));
}

const _bottomNavBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: Color.fromARGB(255, 200, 34, 175),
    unselectedItemColor: Color.fromARGB(255, 68, 68, 68),
    elevation: 0);
const _appBarThemeDark = AppBarTheme(
    backgroundColor: colorBackgroundApp,
    scrolledUnderElevation: 0,
    titleTextStyle:
        TextStyle(color: colorPinkButton, fontWeight: FontWeight.bold),
    elevation: 0);
final _appBarThemeLight = AppBarTheme(
    backgroundColor: colorGrey.shade100,
    scrolledUnderElevation: 0,
    titleTextStyle:
        const TextStyle(color: colorPinkButton, fontWeight: FontWeight.bold),
    elevation: 0);
