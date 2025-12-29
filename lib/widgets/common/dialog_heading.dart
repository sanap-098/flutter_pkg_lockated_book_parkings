import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/divider/common_divider.dart';
import 'package:flutter_pkg_lockated_gophygital_widgets/core/constants/font_constants.dart';
import 'package:provider/provider.dart';

class DialogHeadingWidget extends StatelessWidget {
  const DialogHeadingWidget(
      {Key? key, required this.heading, this.showCloseIcon = true})
      : super(key: key);

  final String heading;
  final bool? showCloseIcon;

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseTextTheme = themeViewModel.baseTextTheme;
    final baseColorTheme = themeViewModel.colors;
    final currentCompany = themeViewModel.currentCompanyName;

    return Column(
      children: [
        Row(
          mainAxisAlignment: currentCompany == CompanyName.viRevamped
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                heading,
                style: currentCompany == CompanyName.viRevamped
                    ? const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: FontConstants.viSemiBold,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)
                    : baseTextTheme.dialogTitleTextStyle,
                textScaleFactor: 1,
              ),
            ),
            if (showCloseIcon != false)
              IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 20,
                    color: baseColorTheme.iconColor,
                  ))
          ],
        ),
        if (themeViewModel.currentCompanyName != CompanyName.viRevamped)
          const CommonDivider()
      ],
    );
  }
}
