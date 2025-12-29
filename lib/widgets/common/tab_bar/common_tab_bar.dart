import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:provider/provider.dart';

import '../../../core/themes/theme_view_model.dart';

class CommonTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final void Function(int)? onTap;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  const CommonTabBar(
      {Key? key,
      required this.tabs,
      this.onTap,
      this.controller,
      this.padding,
      this.isScrollable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseColorTheme = themeViewModel.colors;


  logInfo(msg: "CC : ${themeViewModel.currentCompanyName}");

    if (themeViewModel.currentCompanyName == CompanyName.vi ) {
      return Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFE2E2E2),
              borderRadius: BorderRadius.circular(10)),
          child: TabBar(
            tabs: tabs,
            unselectedLabelColor: const Color(0xFF282828),
            isScrollable: isScrollable ?? false,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            indicator: BoxDecoration(
              color: const Color(0xFFEC2B3E),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: onTap,
            controller: controller,
          ),
        ),
      );
    }
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color(0xFFD6E9FC),
        ))),
        child: TabBar(
          tabs: tabs,
          unselectedLabelColor: Colors.grey,
          
          labelColor: const Color(0xffC72030),
          isScrollable: isScrollable ?? false,
          indicator: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                  bottom: BorderSide(
                    
                      color: Color(0xffC72030),
                      width: 2,
                      style: BorderStyle.solid))),
          onTap: onTap,
          controller: controller,
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:provider/provider.dart';

// import '../../../core/themes/theme_view_model.dart';

// class CommonTabBar extends StatelessWidget {
//   final List<Widget> tabs;
//   final TabController? controller;
//   final void Function(int)? onTap;
//   final EdgeInsetsGeometry? padding;
//   final bool? isScrollable;
//   const CommonTabBar(
//       {Key? key,
//       required this.tabs,
//       this.onTap,
//       this.controller,
//       this.padding,
//       this.isScrollable})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeViewModel = context.watch<ThemeViewModel>();
//     final baseColorTheme = themeViewModel.colors;


//   logInfo(msg: "CC : ${themeViewModel.currentCompanyName}");

//     if (themeViewModel.currentCompanyName == CompanyName.vi ) {
//       return Padding(
//         padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
//         child: Container(
//           decoration: BoxDecoration(
//               color: const Color(0xFFE2E2E2),
//               borderRadius: BorderRadius.circular(10)),
//           child: TabBar(
//             tabs: tabs,
//             unselectedLabelColor: const Color(0xFF282828),
//             isScrollable: isScrollable ?? false,
//             labelColor: Colors.white,
//             labelStyle: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w400,
//               fontSize: 15,
//             ),
//             unselectedLabelStyle: const TextStyle(
//               color: Colors.grey,
//               fontWeight: FontWeight.w400,
//               fontSize: 15,
//             ),
//             indicator: BoxDecoration(
//               color: const Color(0xFFEC2B3E),
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             onTap: onTap,
//             controller: controller,
//           ),
//         ),
//       );
//     }
//     return Padding(
//       padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         decoration: const BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(
//           color: Color(0xFFD6E9FC),
//         ))),
//         child: TabBar(
//           tabs: tabs,
//           unselectedLabelColor: Colors.grey,
//           labelColor: baseColorTheme.primaryColor,
//           isScrollable: isScrollable ?? false,
//           indicator: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.rectangle,
//               border: Border(
//                   bottom: BorderSide(
//                       color: baseColorTheme.primaryColor,
//                       width: 2,
//                       style: BorderStyle.solid))),
//           onTap: onTap,
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }
