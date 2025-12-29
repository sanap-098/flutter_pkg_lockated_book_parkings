import 'package:flutter/material.dart';
import 'package:flutter_pkg_resident_urbanwork_widgets/widgets/common_button.dart' as urban;

class CommonButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final bool? useCustomColor;
  final Color? customColor;
  final bool? paddingRequired;
  final WidgetStateProperty<OutlinedBorder?>? shape;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool isOutlinedButton;
  
  
  final bool shouldShowArrow; 

  const CommonButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.padding,
    this.borderRadius,
    this.useCustomColor = false,
    this.customColor,
    this.paddingRequired,
    this.shape,
    this.backgroundColor,
    this.width,
    this.height,
    this.isOutlinedButton = false,
    this.shouldShowArrow = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10.0),
        child: urban.CommonButton(
          buttonTitle: title,
          onPressed: onTap,
          height: height ?? 48,
          showArrowIcon: shouldShowArrow, 
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/colors.dart';

// class CommonButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String title;
//   final EdgeInsets? padding;
//   final BorderRadiusGeometry? borderRadius;
//   final bool? useCustomColor;
//   final Color? customColor;
//   final bool? paddingRequired;
//   final WidgetStateProperty<OutlinedBorder?>? shape;
//   final Color? backgroundColor;
//   final double? width;
//   final bool isOutlinedButton;
//   final bool shouldShowArrow;

//   const CommonButton(
//       {Key? key,
//       required this.onTap,
//       required this.title,
//       this.padding,
//       this.borderRadius,
//       this.useCustomColor = false,
//       this.customColor,
//       this.paddingRequired,
//       this.shape,
//       this.backgroundColor,
//       this.width,
//       this.isOutlinedButton = false})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final themeViewModel = context.watch<ThemeViewModel>();
//     // final baseColorTheme = themeViewModel.colors;

//     // ADDED: Check for CompanyName.viRevamped
//     if (themeViewModel.currentCompanyName == CompanyName.vi ||
//         themeViewModel.currentCompanyName == CompanyName.viRevamped) {
//       return Expanded(
//         child: Padding(
//           padding: padding ?? const EdgeInsets.all(10.0),
//           child: TextButton(
//               style: ButtonStyle(
//                   shape: shape ??
//                       WidgetStateProperty.all(
//                         RoundedRectangleBorder(
//                             borderRadius:
//                                 borderRadius ?? BorderRadius.circular(5),
//                             side: BorderSide(
//                                 color: isOutlinedButton
//                                     ? const Color(0xFFEC2B3E)
//                                     : Colors.white,
//                                 width: 2)),
//                       ),
//                   backgroundColor: isOutlinedButton
//                       ? null
//                       : WidgetStateProperty.all(
//                           backgroundColor ?? const Color(0xFFEC2B3E)),
//                   foregroundColor: WidgetStateProperty.all(Colors.white),
//                   fixedSize: WidgetStateProperty.all(
//                       Size(width ?? double.infinity, 50))),
//               onPressed: onTap,
//               child: FittedBox(
//                 fit: BoxFit.contain,
//                 child: Text(
//                   title.toUpperCase(),
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: isOutlinedButton
//                           ? const Color(0xFFEC2B3E)
//                           : Colors.white),
//                 ),
//               )),
//         ),
//       );
//     }

//     return Expanded(
//       child: Padding(
//         padding: padding ?? const EdgeInsets.all(8.0),
//         child: InkWell(
//           onTap: onTap,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: useCustomColor == false
//                   ? LinearGradient(
//                       begin: Alignment.centerRight,
//                       end: Alignment.centerLeft,
//                       colors: [
//                         HexColor('#E95420'),
//                         HexColor('#77216F'),
//                       ],
//                     )
//                   : null,
//               border: Border.all(
//                   color: isOutlinedButton
//                       ? HexColor('#E95420')
//                       : Colors.transparent),
//               color: useCustomColor == true
//                   ? (customColor ?? HexColor(eventBackgroundShared))
//                   : null,
//               borderRadius: borderRadius ?? BorderRadius.circular(23),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color:
//                         isOutlinedButton ? HexColor('#E95420') : Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// // import 'package:flutter/material.dart';
// // import 'package:hexcolor/hexcolor.dart';
// // import 'package:provider/provider.dart';
// // import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
// // import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// // import 'package:flutter_pkg_lockated_book_parking/utils/colors.dart';
// // class CommonButton extends StatelessWidget {
// //   final VoidCallback onTap;
// //   final String title;
// //   final EdgeInsets? padding;
// //   final BorderRadiusGeometry? borderRadius;
// //   final bool? useCustomColor;
// //   final Color? customColor;
// //   final bool? paddingRequired;
// //   final WidgetStateProperty<OutlinedBorder?>? shape;
// //   final Color? backgroundColor;
// //   final double? width;
// //   final bool isOutlinedButton;

// //   const CommonButton(
// //       {Key? key,
// //       required this.onTap,
// //       required this.title,
// //       this.padding,
// //       this.borderRadius,
// //       this.useCustomColor = false,
// //       this.customColor,
// //       this.paddingRequired,
// //       this.shape,
// //       this.backgroundColor,
// //       this.width,
// //       this.isOutlinedButton = false})
// //       : super(key: key);
// //   @override
// //   Widget build(BuildContext context) {
// //     final themeViewModel = context.watch<ThemeViewModel>();
// //     // final baseColorTheme = themeViewModel.colors;

// //     if (themeViewModel.currentCompanyName == CompanyName.vi) {
// //       return Expanded(
// //         child: Padding(
// //           padding: padding ?? const EdgeInsets.all(10.0),
// //           child: TextButton(
// //               style: ButtonStyle(
// //                   shape: shape ??
// //                       WidgetStateProperty.all(
// //                         RoundedRectangleBorder(
// //                             borderRadius:
// //                                 borderRadius ?? BorderRadius.circular(5),
// //                             side: BorderSide(
// //                                 color: isOutlinedButton
// //                                     ? const Color(0xFFEC2B3E)
// //                                     : Colors.white,
// //                                 width: 2)),
// //                       ),
// //                   backgroundColor: isOutlinedButton
// //                       ? null
// //                       : WidgetStateProperty.all(
// //                           backgroundColor ?? const Color(0xFFEC2B3E)),
// //                   foregroundColor: WidgetStateProperty.all(Colors.white),
// //                   fixedSize: WidgetStateProperty.all(
// //                       Size(width ?? double.infinity, 50))),
// //               onPressed: onTap,
// //               child: FittedBox(
// //                 fit: BoxFit.contain,
// //                 child: Text(
// //                   title.toUpperCase(),
// //                   style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w600,
// //                       color: isOutlinedButton
// //                           ? const Color(0xFFEC2B3E)
// //                           : Colors.white),
// //                 ),
// //               )),
// //         ),
// //       );
// //     }

// //     return Expanded(
// //       child: Padding(
// //         padding: padding ?? const EdgeInsets.all(8.0),
// //         child: InkWell(
// //           onTap: onTap,
// //           child: Container(
// //             decoration: BoxDecoration(
// //               gradient: useCustomColor == false
// //                   ? LinearGradient(
// //                       begin: Alignment.centerRight,
// //                       end: Alignment.centerLeft,
// //                       colors: [
// //                         HexColor('#E95420'),
// //                         HexColor('#77216F'),
// //                       ],
// //                     )
// //                   : null,
// //               border: Border.all(
// //                   color: isOutlinedButton
// //                       ? HexColor('#E95420')
// //                       : Colors.transparent),
// //               color: useCustomColor == true
// //                   ? (customColor ?? HexColor(eventBackgroundShared))
// //                   : null,
// //               borderRadius: borderRadius ?? BorderRadius.circular(23),
// //             ),
// //             child: Center(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(
// //                   title,
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     color:
// //                         isOutlinedButton ? HexColor('#E95420') : Colors.white,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
