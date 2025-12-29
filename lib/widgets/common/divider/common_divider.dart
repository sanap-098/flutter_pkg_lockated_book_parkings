import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:provider/provider.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseColorTheme = themeViewModel.colors;

    return Divider(
      color: baseColorTheme.dividerColor,
    );
  }
}
