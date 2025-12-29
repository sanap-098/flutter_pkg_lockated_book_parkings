import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/dialog_heading.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    super.key,
    required this.heading,
    required this.title,
    this.onPositivePressed,
    this.onNegativePressed,
    this.nagativeText,
    this.positiveText,
    this.showCloseButton = true,
    this.showNegativeButton = true,
  });

  final String heading;
  final String title;
  final Function()? onPositivePressed;
  final Function()? onNegativePressed;
  final String? nagativeText;
  final String? positiveText;
  final bool showCloseButton;
  final bool showNegativeButton;

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10)
      // ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogHeadingWidget(
              heading: heading,
              showCloseIcon: showCloseButton,
            ),
            // CommonDivider
            const Divider(),
            Text(title),
            Row(
              children: [
                if (showNegativeButton)
                  Expanded(
                    child: ElevatedButton(
                        onPressed: onNegativePressed ??
                            () {
                              Navigator.pop(context);
                            },
                        child: Text(nagativeText ?? 'NO')),
                  ),
                if (showNegativeButton)
                  const SizedBox(
                    width: 10,
                  ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: onPositivePressed,
                      child: Text(positiveText ?? 'YES')),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
