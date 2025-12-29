import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/texts/company_text_theme.dart';

class GoPhygitalRevampedTextTheme extends CompanyTextTheme {
  @override
  TextStyle get itemHeadingTextStyle => const TextStyle(
        fontSize: 15,
        color: Color(0xFF4B4B4B),
      );

  @override
  TextStyle get itemHeadingBoldTextStyle => const TextStyle(
        fontSize: 15,
        color: Color(0xFF4B4B4B),
        fontWeight: FontWeight.bold,
      );
  @override
  TextStyle get dialogTitleTextStyle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF282828),
      );

  @override
  TextStyle get fitnessDialogBoldTextStyle => const TextStyle(
        color: Color(0xFF510005),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get fitnessDialogTextStyle => const TextStyle(
        color: Color(0xFF510005),
        fontSize: 16,
      );

  @override
  TextStyle get fitnessDialogButtonTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF282828),
      );

  @override
  TextStyle get scoreBoardHeading2TextStyle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 11,
        color: Color(0xFF2C001E),
      );

  @override
  TextStyle get appBarTitleTextStyle => const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
}
