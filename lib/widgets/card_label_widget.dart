import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:provider/provider.dart';

class CardLabelWidget extends StatelessWidget {
  final Color labelColor;
  final Color? textColor;
  final FontWeight? fontWeight;

  final String labelText;

  final double? height;

  final Radius? topRightBorderRadius;

  const CardLabelWidget({
    Key? key,
    required this.labelColor,
    this.textColor,
    this.fontWeight,
    required this.labelText,
    this.height,
    this.topRightBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    final baseColorTheme = themeViewModel.colors;
    if (themeViewModel.currentCompanyName == CompanyName.viRevamped || themeViewModel.currentCompanyName == CompanyName.gophygitalRevamped) {
      return Align(
        alignment: FractionalOffset.topRight,
        child: Container(
          width: 77.58,
          height: height ?? 15.16,
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: BorderRadius.circular(15.96),
          ),
          child: Center(
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: 10,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor ?? const Color(0xFFFFFFFF),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );
    }
    return Align(
      alignment: FractionalOffset.topRight,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: topRightBorderRadius ?? const Radius.circular(16),
            bottomLeft: const Radius.circular(16)),
        child: Container(
          color: labelColor,
          height: height ?? 25,
          width: 125,
          child: Center(
              child: Text(
            labelText != '' ? labelText.toUpperCase() : 'NA',
            style: TextStyle(
                fontSize: 12,
                fontWeight: fontWeight ?? FontWeight.w500,
                // shadows: const <Shadow>[
                //   Shadow(
                //     offset: Offset(0, 1),
                //     blurRadius: 8.0,
                //     // blurRadius: 6.0,
                //     color: Colors.black,
                //   ),
                // ],
                color: textColor ?? Colors.white),
            // style: baseTextTheme.cardLabelTextStyle.copyWith(
            //     color:
            //         (themeViewModel.currentCompanyName == CompanyName.godrej &&
            //                 labelColor == baseColorTheme.primaryColor)
            //             ? baseColorTheme.secondaryColor
            //             : null),
            overflow: TextOverflow.ellipsis,
          )),
        ),
      ),
    );
  }
}
