import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/services/location_service_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/card_label_widget.dart';
import 'package:flutter_pkg_lockated_gophygital_widgets/features/widgets/success_card_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_booking_attendance_model/parking_booking_attendance_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_bookings_model/parking_bookings_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/tabs/parking_my_bookings_tab_screen/widgets/dialogs/parking_show_qr_code_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/widgets/dialogs/parking_cancel_dialog.dart';

class ParkingMyBookingsListItemWidget extends StatelessWidget {
  final ParkingBookingsModel item;
  final bool isExpired;
  const ParkingMyBookingsListItemWidget({
    super.key,
    required this.item,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    // Capture the ThemeViewModel from the current context
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseColorTheme = themeViewModel.colors;
    const String packageName = 'flutter_pkg_lockated_book_parking';
    
    // Red color constant
    const Color borderColor = Color(0xffC72030);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(5)),
            child: Stack(
              children: [
                if (item.userStatus != null && !isExpired)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CardLabelWidget(
                      // If status is Pending, use Red. Else use Primary Color.
                      labelColor: (item.userStatus?.toLowerCase() == 'pending')
                          ? const Color(0xffC72030)
                          : baseColorTheme.primaryColor,
                      labelText: item.userStatus!,
                      topRightBorderRadius: const Radius.circular(5),
                    ),
                  ),
                if (isExpired)
                  Positioned(
                    top: 40,
                    left: 40,
                    right: 0,
                    child: Transform.rotate(
                      angle: -0.3,
                      child: Text(
                        'Parking ${item.status?.toLowerCase() == 'expired' ? 'Expired' : 'Cancelled'} ',
                        style: TextStyle(
                            color: HexColor('#EE2737').withOpacity(0.2),
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            item.categoryName != null &&
                                    item.categoryName!.isNotEmpty &&
                                    (item.categoryName!
                                            .toLowerCase()
                                            .contains('car') ||
                                        item.categoryName!
                                            .toLowerCase()
                                            .contains('4'))
                                ? 'assets/transport/parking_car_icon.png'
                                : 'assets/transport/parking_scooter_mini_icon.png',
                            height: 20,
                            package: packageName,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Parking Slot: ${item.showSchedule?.parkingNumber ?? 'NA'}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isExpired
                                            ? HexColor('#9FA5AD')
                                            : null),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Slot Time : ${item.showSchedule?.slot ?? 'NA'}',
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isExpired
                                            ? HexColor('#9FA5AD')
                                            : null),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.bookingDate ?? 'NA',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isExpired
                                            ? HexColor('#9FA5AD')
                                            : null),
                                  ),
                                  Text(
                                    item.showSchedule?.slot != null &&
                                            item.showSchedule!.slot!.isNotEmpty
                                        ? item.showSchedule!.slot!
                                            .split('to')
                                            .first
                                        : 'NA',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isExpired
                                            ? HexColor('#9FA5AD')
                                            : null),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Image.asset(
                                  isExpired
                                      ? 'assets/transport/parking_arrow_disable_icon.png'
                                      : 'assets/transport/parking_arrow_icon.png',
                                  fit: BoxFit.contain,
                                  height: 20,
                                  package: packageName,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.bookingDate ?? 'NA',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isExpired
                                            ? HexColor('#9FA5AD')
                                            : null),
                                  ),
                                  Text(
                                    item.showSchedule?.slot != null &&
                                            item.showSchedule!.slot!.isNotEmpty
                                        ? item.showSchedule!.slot!
                                            .split('to')
                                            .last
                                        : 'NA',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isExpired
                                            ? HexColor('#9FA5AD')
                                            : null),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                   
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: DottedDecoration(
                          shape: Shape.line,
                          linePosition: LinePosition.top,
                          color: Colors.black,
                        ),
                      ),
                      if (!isExpired)
                        Row(
                          children: [
                            TextButton(
                                style: const ButtonStyle(
                                    visualDensity: VisualDensity.compact),
                                onPressed: () {
                                  // FIXED: Passed themeViewModel to dialog using ChangeNotifierProvider.value
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ChangeNotifierProvider.value(
                                        value: themeViewModel,
                                        child: ParkingShowQrCodeDialog(
                                          item: item,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'View Details',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                )),
                            const Expanded(child: SizedBox()),
                            if (item.userStatus == null ||
                                (item.userStatus!.toLowerCase() !=
                                        'checked out' &&
                                    item.userStatus!.toLowerCase() !=
                                        'checked in'))
                              TextButton(
                                  style: const ButtonStyle(
                                      visualDensity: VisualDensity.compact),
                                  onPressed: () {
                                    if (item.id != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          // FIXED: Also passed themeViewModel here to prevent similar crashes
                                          return ChangeNotifierProvider.value(
                                            value: themeViewModel,
                                            child: ParkingCancelDialog(
                                              parkingId: '${item.id!}',
                                              parentContext: context,
                                            ),
                                          );
                                        },
                                      ).then((value) {
                                        if (value as bool == true) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SuccessCardDialog(
                                                parentContext: context,
                                                title:
                                                    'Parking Cancelled Successfully!',
                                              );
                                            },
                                          );
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Cancel Parking',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: HexColor('#EE2737')),
                                  ))
                          ],
                        ),
                      if (isExpired)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                style: const ButtonStyle(
                                    visualDensity: VisualDensity.compact),
                                onPressed: null,
                                child: Text(
                                  'Expired',
                                  style: TextStyle(
                                      fontSize: 14, color: HexColor('#9FA5AD')),
                                )),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            left: -20,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  color: Colors.grey[50],
                  shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: 35,
            right: -20,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  color: Colors.grey[50],
                  shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  ParkingBookingAttendanceModel? getAttendance({
    List<ParkingBookingAttendanceModel>? attendance,
  }) {
    if (attendance == null || attendance.isEmpty) {
      return null;
    } else {
      return attendance.firstOrNull;
    }
  }
}



// import 'package:dotted_decoration/dotted_decoration.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pkg_lockated_book_parking/services/location_service_repository.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/card_label_widget.dart';
// import 'package:flutter_pkg_lockated_gophygital_widgets/features/widgets/success_card_dialog.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_booking_attendance_model/parking_booking_attendance_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_bookings_model/parking_bookings_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/tabs/parking_my_bookings_tab_screen/widgets/dialogs/parking_show_qr_code_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/widgets/dialogs/parking_cancel_dialog.dart';

// class ParkingMyBookingsListItemWidget extends StatelessWidget {
//   final ParkingBookingsModel item;
//   final bool isExpired;
//   const ParkingMyBookingsListItemWidget({
//     super.key,
//     required this.item,
//     this.isExpired = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final themeViewModel = context.watch<ThemeViewModel>();
//     final baseColorTheme = themeViewModel.colors;
//     const String packageName = 'flutter_pkg_lockated_book_parking';
//     const Color borderColor = Color(0xffC72030);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
//       child: Stack(
//         children: [
//           Card(
//             margin: EdgeInsets.zero,
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//                 side: const BorderSide(color: borderColor),
//                 borderRadius: BorderRadius.circular(5)),
//             child: Stack(
//               children: [
//                 if (item.userStatus != null && !isExpired)
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: CardLabelWidget(
//                       labelColor: const Color(0xffC72030),
//                       labelText: item.userStatus!,
//                       topRightBorderRadius: const Radius.circular(5),
//                     ),
//                   ),
//                 if (isExpired)
//                   Positioned(
//                     top: 40,
//                     left: 40,
//                     right: 0,
//                     child: Transform.rotate(
//                       angle: -0.3,
//                       child: Text(
//                         'Parking ${item.status?.toLowerCase() == 'expired' ? 'Expired' : 'Cancelled'} ',
//                         style: TextStyle(
//                             color: HexColor('#EE2737').withOpacity(0.2),
//                             fontSize: 35,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             item.categoryName != null &&
//                                     item.categoryName!.isNotEmpty &&
//                                     (item.categoryName!
//                                             .toLowerCase()
//                                             .contains('car') ||
//                                         item.categoryName!
//                                             .toLowerCase()
//                                             .contains('4'))
//                                 ? 'assets/transport/parking_car_icon.png'
//                                 : 'assets/transport/parking_scooter_mini_icon.png',
//                             height: 20,
//                             package: packageName,
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Parking Slot: ${item.showSchedule?.parkingNumber ?? 'NA'}',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                   const SizedBox(
//                                     height: 4,
//                                   ),
//                                   Text(
//                                     'Slot Time : ${item.showSchedule?.slot ?? 'NA'}',
//                                     maxLines: 5,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
                      
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.bookingDate ?? 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                   Text(
//                                     item.showSchedule?.slot != null &&
//                                             item.showSchedule!.slot!.isNotEmpty
//                                         ? item.showSchedule!.slot!
//                                             .split('to')
//                                             .first
//                                         : 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Image.asset(
//                                   isExpired
//                                       ? 'assets/transport/parking_arrow_disable_icon.png'
//                                       : 'assets/transport/parking_arrow_icon.png',
//                                   fit: BoxFit.contain,
//                                   height: 20,
//                                   package: packageName,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.bookingDate ?? 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                   Text(
//                                     item.showSchedule?.slot != null &&
//                                             item.showSchedule!.slot!.isNotEmpty
//                                         ? item.showSchedule!.slot!
//                                             .split('to')
//                                             .last
//                                         : 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
                   
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         decoration: DottedDecoration(
//                           shape: Shape.line,
//                           linePosition: LinePosition.top,
//                           color: Colors.black,
//                         ),
//                       ),
//                       if (!isExpired)
//                         Row(
//                           children: [
//                             TextButton(
//                                 style: const ButtonStyle(
//                                     visualDensity: VisualDensity.compact),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return ParkingShowQrCodeDialog(
//                                         item: item,
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: const Text(
//                                   'View Details',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 )),
//                             const Expanded(child: SizedBox()),
//                             if (item.userStatus == null ||
//                                 (item.userStatus!.toLowerCase() !=
//                                         'checked out' &&
//                                     item.userStatus!.toLowerCase() !=
//                                         'checked in'))
//                               TextButton(
//                                   style: const ButtonStyle(
//                                       visualDensity: VisualDensity.compact),
//                                   onPressed: () {
//                                     if (item.id != null) {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return ParkingCancelDialog(
//                                             parkingId: '${item.id!}',
//                                             parentContext: context,
//                                           );
//                                         },
//                                       ).then((value) {
//                                         if (value as bool == true) {
//                                           showDialog(
//                                             context: context,
//                                             builder: (context) {
//                                               return SuccessCardDialog(
//                                                 parentContext: context,
//                                                 title:
//                                                     'Parking Cancelled Successfully!',
//                                               );
//                                             },
//                                           );
//                                         }
//                                       });
//                                     }
//                                   },
//                                   child: Text(
//                                     'Cancel Parking',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: HexColor('#EE2737')),
//                                   ))
//                           ],
//                         ),
//                       if (isExpired)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextButton(
//                                 style: const ButtonStyle(
//                                     visualDensity: VisualDensity.compact),
//                                 onPressed: null,
//                                 child: Text(
//                                   'Expired',
//                                   style: TextStyle(
//                                       fontSize: 14, color: HexColor('#9FA5AD')),
//                                 )),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 35,
//             left: -20,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(color: borderColor),
//                   color: Colors.grey[50],
//                   shape: BoxShape.circle),
//             ),
//           ),
//           Positioned(
//             bottom: 35,
//             right: -20,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(color: HexColor(ticketTabColor)),
//                   color: Colors.grey[50],
//                   shape: BoxShape.circle),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   ParkingBookingAttendanceModel? getAttendance({
//     List<ParkingBookingAttendanceModel>? attendance,
//   }) {
//     if (attendance == null || attendance.isEmpty) {
//       return null;
//     } else {
//       return attendance.firstOrNull;
//     }
//   }
// }





// import 'package:dotted_decoration/dotted_decoration.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/card_label_widget.dart';
// import 'package:flutter_pkg_lockated_gophygital_widgets/features/widgets/success_card_dialog.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart'; // Added for DateFormat if needed implicitly

// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';

// // Ensure this file exists and contains the class 'LocationServiceRepository'
// import 'package:flutter_pkg_lockated_book_parking/services/background_lockator/location_service_repository.dart';

// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_booking_attendance_model/parking_booking_attendance_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_bookings_model/parking_bookings_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/tabs/parking_my_bookings_tab_screen/widgets/dialogs/parking_show_qr_code_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/widgets/dialogs/parking_cancel_dialog.dart';

// class ParkingMyBookingsListItemWidget extends StatelessWidget {
//   final ParkingBookingsModel item;
//   final bool isExpired;
//   const ParkingMyBookingsListItemWidget({
//     super.key,
//     required this.item,
//     this.isExpired = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final themeViewModel = context.watch<ThemeViewModel>();
//     final baseColorTheme = themeViewModel.colors;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
//       child: Stack(
//         children: [
//           Card(
//             margin: EdgeInsets.zero,
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//                 side: BorderSide(color: HexColor(ticketTabColor)),
//                 borderRadius: BorderRadius.circular(5)),
//             child: Stack(
//               children: [
//                 if (item.userStatus != null && !isExpired)
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: CardLabelWidget(
//                       labelColor: baseColorTheme.primaryColor,
//                       labelText: item.userStatus!,
//                       topRightBorderRadius: const Radius.circular(5),
//                     ),
//                   ),
//                 if (isExpired)
//                   Positioned(
//                     top: 40,
//                     left: 40,
//                     right: 0,
//                     child: Transform.rotate(
//                       angle: -0.3,
//                       child: Text(
//                         'Parking ${item.status?.toLowerCase() == 'expired' ? 'Expired' : 'Cancelled'} ',
//                         style: TextStyle(
//                             color: HexColor('#EE2737').withValues(alpha: 0.2),
//                             fontSize: 35,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             item.categoryName != null &&
//                                     item.categoryName!.isNotEmpty &&
//                                     (item.categoryName!
//                                             .toLowerCase()
//                                             .contains('car') ||
//                                         item.categoryName!
//                                             .toLowerCase()
//                                             .contains('4'))
//                                 ? 'assets/transport/parking_car_icon.png'
//                                 : 'assets/transport/parking_scooter_mini_icon.png',
//                             height: 20,
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Parking Slot: ${item.showSchedule?.parkingNumber ?? 'NA'}',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                   const SizedBox(
//                                     height: 4,
//                                   ),
//                                   Text(
//                                     'Slot Time : ${item.showSchedule?.slot ?? 'NA'}',
//                                     maxLines: 5,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.bookingDate ?? 'NA',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: isExpired
//                                           ? HexColor('#9FA5AD')
//                                           : null),
//                                 ),
//                                 Text(
//                                   item.showSchedule?.slot != null &&
//                                           item.showSchedule!.slot!.isNotEmpty
//                                       ? item.showSchedule!.slot!
//                                           .split('to')
//                                           .first
//                                       : 'NA',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: isExpired
//                                           ? HexColor('#9FA5AD')
//                                           : null),
//                                 ),
//                               ],
//                             ),
//                             Expanded(
//                               child: Image.asset(
//                                 isExpired
//                                     ? 'assets/transport/parking_arrow_disable_icon.png'
//                                     : 'assets/transport/parking_arrow_icon.png',
//                               ),
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item.bookingDate ?? 'NA',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: isExpired
//                                           ? HexColor('#9FA5AD')
//                                           : null),
//                                 ),
//                                 Text(
//                                   item.showSchedule?.slot != null &&
//                                           item.showSchedule!.slot!.isNotEmpty
//                                       ? item.showSchedule!.slot!
//                                           .split('to')
//                                           .last
//                                       : 'NA',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: isExpired
//                                           ? HexColor('#9FA5AD')
//                                           : null),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         decoration: DottedDecoration(
//                           shape: Shape.line,
//                           linePosition: LinePosition.top,
//                           color: Colors.black,
//                         ),
//                       ),
//                       if (!isExpired)
//                         Row(
//                           children: [
//                             TextButton(
//                                 style: const ButtonStyle(
//                                     visualDensity: VisualDensity.compact),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return ParkingShowQrCodeDialog(
//                                         item: item,
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: const Text(
//                                   'View Details',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 )),
//                             const Expanded(child: SizedBox()),
//                             if (item.userStatus == null ||
//                                 (item.userStatus!.toLowerCase() !=
//                                         'checked out' &&
//                                     item.userStatus!.toLowerCase() !=
//                                         'checked in'))
//                               TextButton(
//                                   style: const ButtonStyle(
//                                       visualDensity: VisualDensity.compact),
//                                   onPressed: () {
//                                     if (item.id != null) {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return ParkingCancelDialog(
//                                             parkingId: '${item.id!}',
//                                             parentContext: context,
//                                           );
//                                         },
//                                       ).then((value) {
//                                         if (value as bool == true) {
//                                           showDialog(
//                                             context: context,
//                                             builder: (context) {
//                                               return SuccessCardDialog(
//                                                 parentContext: context,
//                                                 title:
//                                                     'Parking Cancelled Successfully!',
//                                               );
//                                             },
//                                           );
//                                         }
//                                       });
//                                     }
//                                   },
//                                   child: Text(
//                                     'Cancel Parking',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: HexColor('#EE2737')),
//                                   ))
//                           ],
//                         ),
//                       if (isExpired)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextButton(
//                                 style: const ButtonStyle(
//                                     visualDensity: VisualDensity.compact),
//                                 onPressed: null,
//                                 child: Text(
//                                   'Expired',
//                                   style: TextStyle(
//                                       fontSize: 14, color: HexColor('#9FA5AD')),
//                                 )),
//                           ],
//                         ),
//                       // FIX: Removed 'if (false)' which was causing dead code errors
//                       if (!isExpired &&
//                           item.bookingDate != null &&
//                           Utils.dateTrimNReturnDateTime(item.bookingDate!) !=
//                               null &&
//                           Utils.isToday(
//                               date: Utils.dateTrimNReturnDateTime(
//                                   item.bookingDate ?? '')!))
//                         Row(
//                           children: [
//                             if (getAttendance(attendance: item.attendance)
//                                         ?.punchedInAt ==
//                                     null &&
//                                 getAttendance(attendance: item.attendance)
//                                         ?.punchedOutAt ==
//                                     null)
//                               TextButton(
//                                   style: const ButtonStyle(
//                                       visualDensity: VisualDensity.compact),
//                                   onPressed: () async {
//                                     bool inGeofence = false;
//                                     try {
//                                       Position position =
//                                           await Geolocator.getCurrentPosition(
//                                               desiredAccuracy:
//                                                   LocationAccuracy.high);
//                                       // Ensure LocationServiceRepository is imported correctly
//                                       inGeofence =
//                                           await LocationServiceRepository()
//                                               .setGeoFencing(
//                                                   currentLatitude:
//                                                       position.latitude,
//                                                   currentLongitude:
//                                                       position.longitude);
//                                     } catch (e) {
//                                       logError(msg: e);
//                                       showToastDialog(
//                                           msg:
//                                               'Please check location permission');
//                                       return;
//                                     }

//                                     if (inGeofence && context.mounted) {
//                                       await context
//                                           .read<ParkingBookingProvider>()
//                                           .sendPunchInDetails(
//                                               context: context,
//                                               parkingBookingId: item.id);
//                                     } else {
//                                       showToastDialog(
//                                           msg:
//                                               'You are outside of Geofence Area!');
//                                     }
//                                   },
//                                   child: Text(
//                                     'Check In',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: HexColor('#EE2737')),
//                                   )),
//                             if (getAttendance(attendance: item.attendance)
//                                         ?.punchedInAt !=
//                                     null &&
//                                 getAttendance(attendance: item.attendance)
//                                         ?.punchedOutAt ==
//                                     null)
//                               TextButton(
//                                   style: const ButtonStyle(
//                                       visualDensity: VisualDensity.compact),
//                                   onPressed: () async {
//                                     bool inGeofence = false;
//                                     try {
//                                       Position position =
//                                           await Geolocator.getCurrentPosition(
//                                               desiredAccuracy:
//                                                   LocationAccuracy.high);
//                                       inGeofence =
//                                           await LocationServiceRepository()
//                                               .setGeoFencing(
//                                                   currentLatitude:
//                                                       position.latitude,
//                                                   currentLongitude:
//                                                       position.longitude);
//                                     } catch (e) {
//                                       logError(msg: e);
//                                       // showToastDialog(
//                                       //     msg:
//                                       //         'Please check location permission');
//                                       // return;
//                                     }

//                                     if (!inGeofence && context.mounted) {
//                                       // Correctly calling the method from the Provider
//                                       context
//                                           .read<ParkingBookingProvider>()
//                                           .sendPunchOutDetails(
//                                             context: context,
//                                             attendanceId: getAttendance(
//                                                         attendance:
//                                                             item.attendance)
//                                                     ?.id
//                                                     .toString() ??
//                                                 '',
//                                             workLog: '',
//                                             parkingBookingId: item.id,
//                                           );
//                                     } else {
//                                       showToastDialog(
//                                           msg: 'You are inside Geofence Area!');
//                                     }
//                                   },
//                                   child: Text(
//                                     'Check Out',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: HexColor('#EE2737')),
//                                   ))
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 35,
//             left: -20,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(color: HexColor(ticketTabColor)),
//                   color: Colors.grey[50],
//                   shape: BoxShape.circle),
//             ),
//           ),
//           Positioned(
//             bottom: 35,
//             right: -20,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(color: HexColor(ticketTabColor)),
//                   color: Colors.grey[50],
//                   shape: BoxShape.circle),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   ParkingBookingAttendanceModel? getAttendance({
//     List<ParkingBookingAttendanceModel>? attendance,
//   }) {
//     if (attendance == null || attendance.isEmpty) {
//       return null;
//     } else {
//       return attendance.firstOrNull;
//     }
//   }
// }




// import 'package:dotted_decoration/dotted_decoration.dart';
// import 'package:flutter_pkg_lockated_book_parking/services/location_service_repository.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/card_label_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pkg_lockated_gophygital_widgets/features/widgets/success_card_dialog.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_booking_attendance_model/parking_booking_attendance_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_bookings_model/parking_bookings_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/tabs/parking_my_bookings_tab_screen/widgets/dialogs/parking_show_qr_code_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/widgets/dialogs/parking_cancel_dialog.dart';


// class ParkingMyBookingsListItemWidget extends StatelessWidget {
//   final ParkingBookingsModel item;
//   final bool isExpired;
//   const ParkingMyBookingsListItemWidget({
//     super.key,
//     required this.item,
//     this.isExpired = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final themeViewModel = context.watch<ThemeViewModel>();
//     final baseColorTheme = themeViewModel.colors;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
//       child: Stack(
//         children: [
//           Card(
//             margin: EdgeInsets.zero,
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//                 side: BorderSide(color: HexColor(ticketTabColor)),
//                 borderRadius: BorderRadius.circular(5)),
//             child: Stack(
//               children: [
//                 if (item.userStatus != null && !isExpired)
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: CardLabelWidget(
//                       // labelColor: HexColor(getLabelColor(item.currentStatus ?? '')),
//                       labelColor: baseColorTheme.primaryColor,
//                       labelText: item.userStatus!,
//                       topRightBorderRadius: const Radius.circular(5),
//                     ),
//                   ),
//                 if (isExpired)
//                   Positioned(
//                     top: 40,
//                     left: 40,
//                     right: 0,
//                     child: Transform.rotate(
//                       angle: -0.3,
//                       child: Text(
//                         'Parking ${item.status?.toLowerCase() == 'expired' ? 'Expired' : 'Cancelled'} ',
//                         style: TextStyle(
//                             color: HexColor('#EE2737').withValues(alpha: 0.2),
//                             fontSize: 35,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             item.categoryName != null &&
//                                     item.categoryName!.isNotEmpty &&
//                                     (item.categoryName!
//                                             .toLowerCase()
//                                             .contains('car') ||
//                                         item.categoryName!
//                                             .toLowerCase()
//                                             .contains('4'))
//                                 ? 'assets/transport/parking_car_icon.png'
//                                 : 'assets/transport/parking_scooter_mini_icon.png',
//                             height: 20,
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     // 'Parking Level B3',
//                                     'Parking Slot: ${item.showSchedule?.parkingNumber ?? 'NA'}',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                   const SizedBox(
//                                     height: 4,
//                                   ),
//                                   Text(
//                                     // 'Slot No 15',
//                                     'Slot Time : ${item.showSchedule?.slot ?? 'NA'}',
//                                     maxLines: 5,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Expanded(
//                           //   child:
//                           // )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     // 'June 13, 2023\n09:00 am',
//                                     item.bookingDate ?? 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                   Text(
//                                     // 'June 13, 2023\n09:00 am',
//                                     item.showSchedule?.slot != null &&
//                                             item.showSchedule!.slot!.isNotEmpty
//                                         ? item.showSchedule!.slot!
//                                             .split('to')
//                                             .first
//                                         : 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Image.asset(
//                                 isExpired
//                                     ? 'assets/transport/parking_arrow_disable_icon.png'
//                                     : 'assets/transport/parking_arrow_icon.png',
//                                 // height: ,
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     // 'June 13, 2023\n09:00 am',
//                                     item.bookingDate ?? 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                   Text(
//                                     // 'June 13, 2023\n09:00 am',
//                                     item.showSchedule?.slot != null &&
//                                             item.showSchedule!.slot!.isNotEmpty
//                                         ? item.showSchedule!.slot!
//                                             .split('to')
//                                             .last
//                                         : 'NA',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: isExpired
//                                             ? HexColor('#9FA5AD')
//                                             : null),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         decoration: DottedDecoration(
//                           shape: Shape.line,
//                           linePosition: LinePosition.top,
//                           color: Colors.black,
//                         ),
//                       ),
//                       if (!isExpired)
//                         Row(
//                           children: [
//                             TextButton(
//                                 style: const ButtonStyle(
//                                     visualDensity: VisualDensity.compact),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return ParkingShowQrCodeDialog(
//                                         item: item,
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: const Text(
//                                   'View Details',
//                                   style: TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                 )),
//                             const Expanded(child: SizedBox()),
//                             if (item.userStatus == null ||
//                                 (item.userStatus!.toLowerCase() !=
//                                         'checked out' &&
//                                     item.userStatus!.toLowerCase() !=
//                                         'checked in'))
//                               TextButton(
//                                   style: const ButtonStyle(
//                                       visualDensity: VisualDensity.compact),
//                                   onPressed: () {
//                                     if (item.id != null) {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return ParkingCancelDialog(
//                                             parkingId: '${item.id!}',
//                                             parentContext: context,
//                                           );
//                                         },
//                                       ).then((value) {
//                                         if (value as bool == true) {
//                                           showDialog(
//                                             context: context,
//                                             builder: (context) {
//                                               return SuccessCardDialog(
//                                                 parentContext: context,
//                                                 title:
//                                                     'Parking Cancelled Successfully!',
//                                               );
//                                             },
//                                           );
//                                         }
//                                       });
//                                     }
//                                   },
//                                   child: Text(
//                                     'Cancel Parking',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: HexColor('#EE2737')),
//                                   ))
//                           ],
//                         ),
//                       if (isExpired)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextButton(
//                                 style: const ButtonStyle(
//                                     visualDensity: VisualDensity.compact),
//                                 onPressed: null,
//                                 child: Text(
//                                   'Expired',
//                                   style: TextStyle(
//                                       fontSize: 14, color: HexColor('#9FA5AD')),
//                                 )),
//                           ],
//                         ),
//                       if (!isExpired &&
//                           item.bookingDate != null &&
//                           Utils.dateTrimNReturnDateTime(item.bookingDate!) !=
//                               null &&
//                           Utils.isToday(
//                               date: Utils.dateTrimNReturnDateTime(
//                                   item.bookingDate ?? '')!))
//                         if (false)
//                           Row(
//                             children: [
//                               if (getAttendance(attendance: item.attendance)
//                                           ?.punchedInAt ==
//                                       null &&
//                                   getAttendance(attendance: item.attendance)
//                                           ?.punchedOutAt ==
//                                       null)
//                                 TextButton(
//                                     style: const ButtonStyle(
//                                         visualDensity: VisualDensity.compact),
//                                     onPressed: () async {
//                                       bool inGeofence = false;
//                                       try {
//                                         Position position =
//                                             await Geolocator.getCurrentPosition(
//                                                 desiredAccuracy:
//                                                     LocationAccuracy.high);
//                                         inGeofence =
//                                             await LocationServiceRepository()
//                                                 .setGeoFencing(
//                                                     currentLatitude:
//                                                         position.latitude,
//                                                     currentLongitude:
//                                                         position.longitude);
//                                       } catch (e) {
//                                         logError(msg: e);
//                                         showToastDialog(
//                                             msg:
//                                                 'Please check location permission');
//                                         return;
//                                       }

//                                       if (inGeofence && context.mounted) {
//                                         await context
//                                             .read<ParkingBookingProvider>()
//                                             .sendPunchInDetails(
//                                                 context: context,
//                                                 parkingBookingId: item.id);
//                                       } else {
//                                         showToastDialog(
//                                             msg:
//                                                 'You are outside of Geofence Area!');
//                                       }
//                                     },
//                                     child: Text(
//                                       'Check In',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: HexColor('#EE2737')),
//                                     )),
//                               if (getAttendance(attendance: item.attendance)
//                                           ?.punchedInAt !=
//                                       null &&
//                                   getAttendance(attendance: item.attendance)
//                                           ?.punchedOutAt ==
//                                       null)
//                                 TextButton(
//                                     style: const ButtonStyle(
//                                         visualDensity: VisualDensity.compact),
//                                     onPressed: () async {
//                                       bool inGeofence = false;
//                                       try {
//                                         Position position =
//                                             await Geolocator.getCurrentPosition(
//                                                 desiredAccuracy:
//                                                     LocationAccuracy.high);
//                                         inGeofence =
//                                             await LocationServiceRepository()
//                                                 .setGeoFencing(
//                                                     currentLatitude:
//                                                         position.latitude,
//                                                     currentLongitude:
//                                                         position.longitude);
//                                       } catch (e) {
//                                         logError(msg: e);
//                                         // showToastDialog(
//                                         //     msg:
//                                         //         'Please check location permission');
//                                         // return;
//                                       }

//                                       if (!inGeofence && context.mounted) {
//                                         context
//                                             .read<ParkingBookingProvider>()
//                                             .sendPunchOutDetails(
//                                               context: context,
//                                               attendanceId: getAttendance(
//                                                           attendance:
//                                                               item.attendance)
//                                                       ?.id
//                                                       .toString() ??
//                                                   '',
//                                               workLog: '',
//                                               parkingBookingId: item.id,
//                                             );
//                                       } else {
//                                         showToastDialog(
//                                             msg:
//                                                 'You are inside Geofence Area!');
//                                       }
//                                     },
//                                     child: Text(
//                                       'Check Out',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: HexColor('#EE2737')),
//                                     ))
//                             ],
//                           ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 35,
//             left: -20,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(color: HexColor(ticketTabColor)),
//                   color: Colors.grey[50],
//                   shape: BoxShape.circle),
//             ),
//           ),
//           Positioned(
//             bottom: 35,
//             right: -20,
//             child: Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(color: HexColor(ticketTabColor)),
//                   color: Colors.grey[50],
//                   shape: BoxShape.circle),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   ParkingBookingAttendanceModel? getAttendance({
//     List<ParkingBookingAttendanceModel>? attendance,
//   }) {
//     if (attendance == null || attendance.isEmpty) {
//       return null;
//     } else {
//       return attendance.firstOrNull;
//     }
//   }
// }
