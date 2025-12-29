import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_gophygital_widgets/core/constants/font_constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? leadingCallback;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;
  final double? height;
  final bool showBackButton;
  final CompanyName? currentCompanyName;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leadingCallback,
    this.centerTitle,
    this.bottom,
    this.height,
    this.showBackButton = true,
    this.currentCompanyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: centerTitle ?? false, 
            leading: showBackButton
                ? IconButton(
                    onPressed: () {
                      if (leadingCallback == null) {
                        Navigator.pop(context);
                      } else {
                        leadingCallback!();
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black, 
                      size: 24,
                    ),
                  )
                : null,
            title: Text(
              toBeginningOfSentenceCase(title) ?? '',
              style: const TextStyle(
                fontFamily: 'WorkSansM', 
                color: Color(0xff1A1A1A), 
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: actions,
            bottom: bottom,
          ),
        ),
       
        const Divider(
          color: Color(0xffC72030), 
          thickness: 3,
          height: 0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 60.0);
}



// import 'package:flutter/material.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/company_name.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_gophygital_widgets/core/constants/font_constants.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final List<Widget>? actions;
//   final VoidCallback? leadingCallback;
//   final bool? centerTitle;
//   final PreferredSizeWidget? bottom;
//   final double? height;
//   final bool showBackButton;
//   final CompanyName? currentCompanyName;

//   const CommonAppBar({
//     Key? key,
//     required this.title,
//     this.actions,
//     this.leadingCallback,
//     this.centerTitle,
//     this.bottom,
//     this.height,
//     this.showBackButton = true,
//     this.currentCompanyName,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeViewModel = context.watch<ThemeViewModel>();
//     final baseTextTheme = themeViewModel.baseTextTheme;
//     if (themeViewModel.currentCompanyName == CompanyName.viRevamped) {
//       return Padding(
//         padding: const EdgeInsets.only(top: 10),
//         child: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           centerTitle: false,
//           // centerTitle: centerTitle ?? false,
//           // leadingWidth: 70,
//           // centerTitle: false,
//           // leading: showBackButton
//           //     ? InkWell(
//           //         onTap: () {
//           //           if (leadingCallback == null) {
//           //             Navigator.pop(context);
//           //           } else {
//           //             leadingCallback!();
//           //           }
//           //         },
//           //         child: Padding(
//           //           padding: const EdgeInsets.all(8.0),
//           //           child: Container(
//           //             height: 32,
//           //             width: 32,
//           //             decoration: BoxDecoration(
//           //                 color: Colors.white,
//           //                 border: Border.all(color: Color(0xFF2F3043)),
//           //                 shape: BoxShape.circle),
//           //             child: Icon(
//           //               Icons.arrow_back,
//           //             ),
//           //           ),
//           //         ),
//           //       )
//           //     : null,
//           leading: showBackButton
//               ? IconButton(
//                   onPressed: () {
//                     if (leadingCallback == null) {
//                       Navigator.pop(context);
//                     } else {
//                       leadingCallback!();
//                     }
//                   },
//                   icon: Image.asset(
//                     'assets/vi_revamp/arrow_back.png',
//                     height: 32,
//                     width: 32,
//                   )
//                   // Container(
//                   //   height: 32,
//                   //   width: 32,
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       border: Border.all(color: Color(0xFF2F3043)),
//                   //       shape: BoxShape.circle),
//                   //   child: Icon(
//                   //     Icons.arrow_back,
//                   //   ),
//                   // ),
//                   )
//               : null,
//           title: Text(
//             toBeginningOfSentenceCase(title) ?? '',
//             textAlign: TextAlign.start,
//             style: const TextStyle(
//                 color: Color(0xFF000000),
//                 fontFamily: FontConstants.viMedium,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20),
//           ),
//           actions: actions,
//           bottom: bottom,
//         ),
//       );
//     }

//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.white,
//       centerTitle: centerTitle ?? true,
//       leading: showBackButton
//           ? InkWell(
//               onTap: () {
//                 if (leadingCallback == null) {
//                   Navigator.pop(context);
//                 } else {
//                   leadingCallback!();
//                 }
//               },
//               child: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Color(0xFF2C3E50),
//                 size: 20,
//               ),
//             )
//           : null,
//       title: Text(
//         toBeginningOfSentenceCase(title) ?? '',
//         style: baseTextTheme.appBarTitleTextStyle,
//         // style: const TextStyle(
//         //   color: Colors.black,
//         //   fontWeight: FontWeight.bold,
//         //   fontSize: 16
//         // ),
//       ),
//       actions: actions,
//       bottom: bottom,
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(70
//       // (currentCompanyName != null &&
//       //         CompanyName.viRevamped == currentCompanyName
//       //     ? 60.0
//       //     : 50.0),
//       );
// }
