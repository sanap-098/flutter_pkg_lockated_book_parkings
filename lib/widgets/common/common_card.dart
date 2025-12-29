import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/card_label_widget.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? outerPadding;
  final Color? labelColor;
  final String? labelText;
  final void Function()? onTap;
  final Border? border;
  final bool isOutlined;
  final DecorationImage? image;

  const CommonCard(
      {Key? key,
      required this.child,
      this.margin,
      this.color,
      this.shape,
      this.outerPadding,
      this.labelColor,
      this.labelText,
      this.onTap,
      this.border,
      this.isOutlined = false,
      this.image,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    final baseColorTheme = themeViewModel.colors;

    if (themeViewModel.currentCompanyName == CompanyName.viRevamped ||
        themeViewModel.currentCompanyName == CompanyName.gophygitalRevamped) {
      return Padding(
        padding: outerPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: isOutlined
                ? BoxDecoration(
                    border: border ??
                        Border.all(color: const Color(0xFF2F3043), width: .5),
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8))
                : ShapeDecoration(
                    color: color ?? const Color(0xFFFFFFFF),
                    shape: shape ?? baseShapeTheme.commonCardBorderShape,
                    image: image,
                    shadows: [
                      BoxShadow(
                          color: const Color(0xff000000).withValues(alpha: .12),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 1)),
                    ],
                  ),
            margin: margin,
            child: Stack(
              children: [
                child,
                if (labelText != null && labelText!.isNotEmpty)
                  Positioned(
                    top: themeViewModel.currentCompanyName ==
                            CompanyName.gophygitalRevamped
                        ? 15
                        : 5,
                    right: themeViewModel.currentCompanyName ==
                            CompanyName.gophygitalRevamped
                        ? 15
                        : 13,
                    child: CardLabelWidget(
                        // labelColor: HexColor(getLabelColor(item.currentStatus ?? '')),
                        labelColor: labelColor ?? baseColorTheme.primaryColor,
                        labelText: labelText!),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: outerPadding ??
          const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          // elevation: 2,

          // shape: shape ?? baseShapeTheme.commonCardBorderShape,
          decoration: ShapeDecoration(
            color: color ?? Colors.white,
            shape: shape ?? baseShapeTheme.commonCardBorderShape,
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 5,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          margin: margin,
          child: Stack(
            children: [
              child,
              if (labelText != null && labelText!.isNotEmpty)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CardLabelWidget(
                      // labelColor: HexColor(getLabelColor(item.currentStatus ?? '')),
                      labelColor: labelColor ?? baseColorTheme.primaryColor,
                      labelText: labelText!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
