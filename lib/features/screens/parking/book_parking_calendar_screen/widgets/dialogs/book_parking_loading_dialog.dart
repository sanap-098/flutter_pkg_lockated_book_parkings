import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:provider/provider.dart';


class BookParkingLoadingDialog extends StatefulWidget {
  const BookParkingLoadingDialog({super.key});

  @override
  State<BookParkingLoadingDialog> createState() => _BookParkingLoadingDialogState();
}

class _BookParkingLoadingDialogState extends State<BookParkingLoadingDialog> {
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          color: Colors.red,
          duration: const Duration(
            seconds: 5,
          ),
          curve: Curves.easeInOut,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
