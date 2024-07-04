import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: GoogleFonts.raleway().fontFamily,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.grey[300]!,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.grey[900]!,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Colors.grey[300]!,
    onSurface: Colors.black,
    tertiary: Colors.blue[800],
    tertiaryFixed: Colors.grey[50],
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[500]!,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  fontFamily: GoogleFonts.raleway().fontFamily,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.grey[900]!,
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.grey[50]!,
    error: Colors.redAccent,
    onError: Colors.black,
    surface: Colors.grey[900]!,
    onSurface: Colors.white,
    tertiary: Colors.blue[800],
    tertiaryFixed: Colors.grey[50],
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[500]!,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.black,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  ),
);
