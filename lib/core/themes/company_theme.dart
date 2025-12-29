import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/colors/gophygital_revamped_colors.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/colors/vi_revamped_colors.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/constants/gophygital_revamped_constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/constants/vi_revamped_constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/image_constants/gophygital_revamped_image_constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/image_constants/vi_revamped_image_constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/shapes/company_shapes.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/shapes/gophygital_revamped_shapes.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/shapes/gophygital_shapes.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/shapes/vi_revamped_shapes.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/shapes/vi_shapes.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/texts/gophygital_revamped_text_theme.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/texts/vi_revamped_text_theme.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_data/gophygital_revamped_theme_data.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_data/vi_revamped_theme_data.dart';
import 'colors/company_colors.dart';
import 'colors/gophygital_colors.dart';
import 'colors/vi_colors.dart';
import 'constants/company_constants.dart';
import 'constants/gophygital_constants.dart';
import 'constants/vi_constants.dart';
import 'image_constants/company_image_constants.dart';
import 'image_constants/gophygital_image_constants.dart';
import 'image_constants/vi_image_constants.dart';
import 'texts/company_text_theme.dart';
import 'texts/gophygital_text_theme.dart';
import 'texts/vi_text_theme.dart';
import 'theme_data/gophygital_theme_data.dart';
import 'theme_data/vi_theme_data.dart';

class CompanyTheme {
  late CompanyColors colors;
  late CompanyTextTheme textTheme;
  late ThemeData themeData;
  late CompanyConstants companyConstants;
  late CompanyImageConstants companyImageConstants;
  late CompanyShapes companyShapes;

  CompanyTheme.gophygital() {
    colors = GoPhygitalColors();
    textTheme = GoPhygitalTextTheme();
    themeData = GoPhygitalThemeData().themeData;
    companyConstants = GoPhygitalConstants();
    companyImageConstants = GoPhygitalImageConstants();
    companyShapes = GoPhygitalShapes();
  }

  CompanyTheme.vi() {
    colors = ViColors();
    textTheme = ViTextTheme();
    themeData = ViThemeData().themeData;
    companyConstants = ViConstants();
    companyImageConstants = ViImageConstants();
    companyShapes = ViShapes();
  }

  CompanyTheme.viRevamped() {
    colors = ViRevampedColors();
    textTheme = ViRevampedTextTheme();
    themeData = ViRevampedThemeData().themeData;
    companyConstants = ViRevampedConstants();
    companyImageConstants = ViRevampedImageConstants();
    companyShapes = ViRevampedShapes();
  }

  CompanyTheme.gophygitalRevamped() {
    colors = GoPhygitalRevampedColors();
    textTheme = GoPhygitalRevampedTextTheme();
    themeData = GoPhygitalRevampedThemeData().themeData;
    companyConstants = GoPhygitalRevampedConstants();
    companyImageConstants = GoPhygitalRevampedImageConstants();
    companyShapes = GoPhygitalRevampedShapes();
  }
}
