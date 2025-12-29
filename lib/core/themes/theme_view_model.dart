import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors/company_colors.dart';
import 'company_name.dart';
import 'company_theme.dart';
import 'constants/company_constants.dart';
import 'image_constants/company_image_constants.dart';
import 'shapes/company_shapes.dart';
import 'texts/company_text_theme.dart';

class ThemePreference {
  final String companyName;

  ThemePreference(this.companyName);
}

class ThemeViewModel with ChangeNotifier {
  static const String keyPrefferedBrightness = 'PREFERRED_BRIGHTNESS';

  static const String companyGoPhygital = 'COMPANY_GOPHYGITAL';

  static const String companyGophygitalRevamped = 'COMPANY_GOPHYGITAL_REVAMPED';

  static const String companyVi = 'COMPANY_VI';

  static const String companyViRevamped = 'COMPANY_VI_REVAMPED';

  static const String keyCompany = 'COMPANY_NAME';

  // static const String defaultCompany = companyGoPhygital;
  // static const String defaultCompany = companyVi;
  // static const String defaultCompany = companyViRevamped;
  static const String defaultCompany = companyGophygitalRevamped;

  static const Map<CompanyName, String> _companies = {
    CompanyName.gophygital: companyGoPhygital,
    CompanyName.vi: companyVi,
    CompanyName.gophygitalRevamped: companyGophygitalRevamped,
  };

  late CompanyTheme _currentTheme;
  late CompanyName _currentCompanyName;

  CompanyColors get colors => _currentTheme.colors;

  CompanyTheme get currentTheme => _currentTheme;

  CompanyTextTheme get baseTextTheme => _currentTheme.textTheme;

  CompanyConstants get constants => _currentTheme.companyConstants;

  CompanyName get currentCompanyName => _currentCompanyName;

  CompanyShapes get companyShapeTheme => _currentTheme.companyShapes;

  CompanyImageConstants get imageConstants =>
      _currentTheme.companyImageConstants;

  ThemeViewModel() {
    _buildTheme(ThemePreference(defaultCompany));
    _currentThemePreference.then((value) {
      _buildTheme(value);
      notifyListeners();
    });
  }

  Future<ThemePreference> get _currentThemePreference async {
    // final String preferredBrightness =
    //     await (preference.getString(KEY_PREFERRED_BRIGHTNESS) ?? '');
    // if (preferredBrightness.isEmpty) {
    //   brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness;
    // } else {
    //   brightness =
    //       _brightness.entries.firstWhere((element) => element.value == preferredBrightness).key;
    // }

    final SharedPreferences preference = await SharedPreferences.getInstance();
    String preferredCompany =
        preference.getString(keyCompany) ?? defaultCompany;
    return ThemePreference(preferredCompany);
  }

  // toggleBrightness() {
  //   final String companyName =
  //       _companies.entries.firstWhere((e) => e.key == _currentCompanyName).value;
  //   String toBeUpdatedBrightness;
  //   if (_currentTheme.brightness == Brightness.dark) {
  //     var themePreference = ThemePreference(companyName, Brightness.light);
  //     _buildTheme(themePreference);
  //     toBeUpdatedBrightness = _LIGHT_BRIGHTNESS;
  //   } else {
  //     final themePreference = ThemePreference(companyName, Brightness.dark);
  //     _buildTheme(themePreference);
  //     toBeUpdatedBrightness = _DARK_BRIGHTNESS;
  //   }
  //   preference.putString(KEY_PREFERRED_BRIGHTNESS, toBeUpdatedBrightness);
  //   notifyListeners();
  // }

  updateCompany(CompanyName name) async {
    final SharedPreferences preference = await SharedPreferences.getInstance();
    String companyName =
        _companies.entries.firstWhere((element) => element.key == name).value;
    preference.setString(keyCompany, companyName);
    final themePreference = ThemePreference(companyName);
    _buildTheme(themePreference);
    notifyListeners();
  }

  _buildTheme(ThemePreference themePreference) {
    switch (themePreference.companyName) {
      case companyGoPhygital:
        _currentCompanyName = CompanyName.gophygital;
        _currentTheme = CompanyTheme.gophygital();
        break;
      case companyVi:
        _currentCompanyName = CompanyName.vi;
        _currentTheme = CompanyTheme.vi();
        break;
      case companyViRevamped:
        _currentCompanyName = CompanyName.viRevamped;
        _currentTheme = CompanyTheme.viRevamped();
        break;
      case companyGophygitalRevamped:
        _currentCompanyName = CompanyName.gophygitalRevamped;
        _currentTheme = CompanyTheme.gophygitalRevamped();
    }
  }
}
