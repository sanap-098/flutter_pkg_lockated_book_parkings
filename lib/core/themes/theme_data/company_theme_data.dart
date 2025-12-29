import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/colors/gophygital_colors.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CompanyThemeData {
  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  CompanyThemeData(Color primaryColor, Color secondaryColor) {
    _themeData = ThemeData(
        useMaterial3: false,
        primarySwatch: createMaterialColor(primaryColor),
        textTheme: GoogleFonts.latoTextTheme(),
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade50,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.blueGrey.shade700,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          isCollapsed: true,
          fillColor: Colors.white,
          filled: true,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: GoPhygitalColors().primaryColor,
            foregroundColor: Colors.white));
  }
}

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
