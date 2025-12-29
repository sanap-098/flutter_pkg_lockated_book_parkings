import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart'; // Import CommonButton
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/common/common_app_bar.dart';
import 'widgets/parking_management_booked_seat_widget.dart';
import 'widgets/parking_management_custom_calendar_widget.dart';
import 'widgets/parking_management_fixed_booking_list_widget.dart';
import 'widgets/parking_management_roaster_widget.dart';
import 'widgets/parking_management_seat_approval_request_widget.dart';
import 'widgets/parking_management_static_seat_booking_widget.dart';
import 'widgets/parking_management_tower_floor_selection_widget.dart';

class ParkingManagementScreen extends StatefulWidget {
  const ParkingManagementScreen({
    Key? key,
    this.isFromNoti = false,
    this.selectedDate,
  }) : super(key: key);
  final bool isFromNoti;
  final String? selectedDate;

  @override
  State<ParkingManagementScreen> createState() =>
      _ParkingManagementScreenState();
}

class _ParkingManagementScreenState extends State<ParkingManagementScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ParkingManagementProvider>(context, listen: false).init(
            context: context,
            selectDate: widget.selectedDate != null
                ? DateFormat('dd/MM/yyyy').parse(widget.selectedDate!)
                : null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Theme logic handled within widgets like CommonAppBar and CommonButton
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Parking Management',
        leadingCallback: () {
          if (widget.isFromNoti) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home_screen', (route) => false);
          } else {
            Navigator.pop(context);
          }
        },
        actions: [
          InkWell(
            onTap: () {
              Navigator.popAndPushNamed(
                  context, 'parking_management_bookings_and_request_screen');
            },
            child: const Icon(Icons.list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (context
                    .watch<ParkingManagementProvider>()
                    .totalBookingDaysPerWeek >
                0)
              ParkingManagementRoasterWidget(
                  bookedDaysPerWeek: context
                      .watch<ParkingManagementProvider>()
                      .bookedDaysPerWeek,
                  totalBookingDaysPerWeek: context
                      .watch<ParkingManagementProvider>()
                      .totalBookingDaysPerWeek,
                  roasterType:
                      context.watch<ParkingManagementProvider>().roasterType),
            const ParkingManagementCustomCalendarWidget(),
            const ParkingManagementStaticSeatBookingWidget(),
            if (!context
                    .watch<ParkingManagementProvider>()
                    .showApprovalRequestView &&
                Provider.of<ParkingManagementProvider>(context, listen: true)
                    .selectedDateBookedSeats
                    .isNotEmpty)
              ParkingManagementBookedSeatsWidget(
                seatBookigs: Provider.of<ParkingManagementProvider>(context,
                        listen: true)
                    .selectedDateBookedSeats,
                parentContext: context,
              ),
            if (!context
                    .watch<ParkingManagementProvider>()
                    .isSelectedDateBefore &&
                !context
                    .watch<ParkingManagementProvider>()
                    .showApprovalRequestView &&
                Provider.of<ParkingManagementProvider>(context, listen: true)
                    .selectedDateBookedSeats
                    .isEmpty)
              ParkingManagementTowerFloorSelectionWidget(
                building: context.watch<ParkingManagementProvider>().buildings,
                floors: context.watch<ParkingManagementProvider>().floors,
                buildingName:
                    context.watch<ParkingManagementProvider>().buildingName,
                floorName: context.watch<ParkingManagementProvider>().floorName,
              ),
            if (!context
                    .watch<ParkingManagementProvider>()
                    .isSelectedDateBefore &&
                !context
                    .watch<ParkingManagementProvider>()
                    .showApprovalRequestView &&
                Provider.of<ParkingManagementProvider>(context, listen: true)
                    .selectedDateBookedSeats
                    .isEmpty)
              const ParkingManagementFixedBookingListWidget(),
            if (context
                    .watch<ParkingManagementProvider>()
                    .showApprovalRequestView &&
                context
                        .watch<ParkingManagementProvider>()
                        .seatApprovalRequestModel !=
                    null)
              ParkingManagementSeatApprovalRequestWidget(
                item: context
                    .watch<ParkingManagementProvider>()
                    .seatApprovalRequestModel!,
              ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (context.watch<ParkingManagementProvider>().showRequestButton)
             CommonButton(
                onTap: () async {
                  Provider.of<ParkingManagementProvider>(context, listen: false)
                      .sendRequestOpenPopupDialog(context: context);
                },
                title: 'Send Request',
             ),
          
          if (!context.watch<ParkingManagementProvider>().showRequestButton &&
              context.watch<ParkingManagementProvider>().showBookSpaceButton)
             CommonButton(
                onTap: () async {
                  int? seatConfigurationId =
                      Provider.of<ParkingManagementProvider>(context,
                              listen: false)
                          .bookSpaceSeatConfigurationId;
                  if (seatConfigurationId == null) {
                    showToastDialog(msg: somethingWentWrong);
                    return;
                  }

                  Provider.of<ParkingManagementProvider>(context,
                          listen: false)
                      .openApprovedBookSeatScreen(
                          context: context,
                          seatConfigurationId: seatConfigurationId);
                },
                title: 'Book Parking',
             ),
        ],
      ),
    );
  }
}






// // import 'package:flutter/material.dart';
// // import 'package:flutter/scheduler.dart';
// // import 'package:flutter_go_phygital/core/routes.dart';
// // import 'package:flutter_go_phygital/providers/parking_management/parking_management_provider.dart';
// // import 'package:flutter_go_phygital/utils/constants.dart';
// // import 'package:flutter_go_phygital/widgets/common/toast_dialog.dart';
// // import 'package:hexcolor/hexcolor.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';

// // import '../../../widgets/common/common_app_bar.dart';
// // import 'widgets/parking_management_booked_seat_widget.dart';
// // import 'widgets/parking_management_custom_calendar_widget.dart';
// // import 'widgets/parking_management_fixed_booking_list_widget.dart';
// // import 'widgets/parking_management_roaster_widget.dart';
// // import 'widgets/parking_management_seat_approval_request_widget.dart';
// // import 'widgets/parking_management_static_seat_booking_widget.dart';
// // import 'widgets/parking_management_tower_floor_selection_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../../../widgets/common/common_app_bar.dart';
// import 'widgets/parking_management_booked_seat_widget.dart';
// import 'widgets/parking_management_custom_calendar_widget.dart';
// import 'widgets/parking_management_fixed_booking_list_widget.dart';
// import 'widgets/parking_management_roaster_widget.dart';
// import 'widgets/parking_management_seat_approval_request_widget.dart';
// import 'widgets/parking_management_static_seat_booking_widget.dart';
// import 'widgets/parking_management_tower_floor_selection_widget.dart';
// class ParkingManagementScreen extends StatefulWidget {
//   const ParkingManagementScreen({
//     Key? key,
//     this.isFromNoti = false,
//     this.selectedDate,
//   }) : super(key: key);
//   final bool isFromNoti;
//   final String? selectedDate;

//   @override
//   State<ParkingManagementScreen> createState() =>
//       _ParkingManagementScreenState();
// }

// class _ParkingManagementScreenState extends State<ParkingManagementScreen> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) =>
//         Provider.of<ParkingManagementProvider>(context, listen: false).init(
//             context: context,
//             selectDate: widget.selectedDate != null
//                 ? DateFormat('dd/MM/yyyy').parse(widget.selectedDate!)
//                 : null));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(
//         title: 'Parking Management',
//         leadingCallback: () {
//           if (widget.isFromNoti) {
//             Navigator.pushNamedAndRemoveUntil(
//                 context, 'home_screen', (route) => false);
//             // Navigator.pushNamedAndRemoveUntil(
//             //     context, Routes.homeScreen, (route) => false);
//           } else {
//             Navigator.pop(context);
//           }
//         },
//         actions: [
//           InkWell(
//             onTap: () {
//               Navigator.popAndPushNamed(
//                   context, 'parking_management_bookings_and_request_screen');
//               // Navigator.popAndPushNamed(
//               //     context, Routes.parkingManagementBookingsAndRequestScreen);
//             },
//             child: const Icon(Icons.list),
//           ),
//         ],
//       ),
//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   leading: InkWell(
//       //     onTap: () {
//       //       if (widget.isFromNoti) {
//       //         Navigator.pushNamedAndRemoveUntil(
//       //             context, Routes.homeScreen, (route) => false);
//       //       } else {
//       //         Navigator.pop(context);
//       //       }
//       //     },
//       //     child: const Icon(Icons.arrow_back_ios),
//       //   ),
//       //   title: const Center(
//       //     child: Text(
//       //       'Parking Management',
//       //       style: TextStyle(
//       //         color: Colors.black,
//       //       ),
//       //     ),
//       //   ),
//       //   centerTitle: true,
//       //   actions: [
//       //     InkWell(
//       //       onTap: () {
//       //         Navigator.popAndPushNamed(
//       //             context, Routes.parkingManagementBookingsAndRequestScreen);
//       //       },
//       //       child: const Icon(Icons.list),
//       //     ),
//       //   ],
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             if (context
//                     .watch<ParkingManagementProvider>()
//                     .totalBookingDaysPerWeek >
//                 0)
//               ParkingManagementRoasterWidget(
//                   bookedDaysPerWeek: context
//                       .watch<ParkingManagementProvider>()
//                       .bookedDaysPerWeek,
//                   totalBookingDaysPerWeek: context
//                       .watch<ParkingManagementProvider>()
//                       .totalBookingDaysPerWeek,
//                   roasterType:
//                       context.watch<ParkingManagementProvider>().roasterType),
//             const ParkingManagementCustomCalendarWidget(),
//             const ParkingManagementStaticSeatBookingWidget(),
//             if (!context
//                     .watch<ParkingManagementProvider>()
//                     .showApprovalRequestView &&
//                 Provider.of<ParkingManagementProvider>(context, listen: true)
//                     .selectedDateBookedSeats
//                     .isNotEmpty)
//               ParkingManagementBookedSeatsWidget(
//                 seatBookigs: Provider.of<ParkingManagementProvider>(context,
//                         listen: true)
//                     .selectedDateBookedSeats,
//                 parentContext: context,
//               ),
//             if (!context
//                     .watch<ParkingManagementProvider>()
//                     .isSelectedDateBefore &&
//                 !context
//                     .watch<ParkingManagementProvider>()
//                     .showApprovalRequestView &&
//                 Provider.of<ParkingManagementProvider>(context, listen: true)
//                     .selectedDateBookedSeats
//                     .isEmpty)
//               ParkingManagementTowerFloorSelectionWidget(
//                 building: context.watch<ParkingManagementProvider>().buildings,
//                 floors: context.watch<ParkingManagementProvider>().floors,
//                 buildingName:
//                     context.watch<ParkingManagementProvider>().buildingName,
//                 floorName: context.watch<ParkingManagementProvider>().floorName,
//               ),
//             if (!context
//                     .watch<ParkingManagementProvider>()
//                     .isSelectedDateBefore &&
//                 !context
//                     .watch<ParkingManagementProvider>()
//                     .showApprovalRequestView &&
//                 Provider.of<ParkingManagementProvider>(context, listen: true)
//                     .selectedDateBookedSeats
//                     .isEmpty)
//               const ParkingManagementFixedBookingListWidget(),
//             if (context
//                     .watch<ParkingManagementProvider>()
//                     .showApprovalRequestView &&
//                 context
//                         .watch<ParkingManagementProvider>()
//                         .seatApprovalRequestModel !=
//                     null)
//               ParkingManagementSeatApprovalRequestWidget(
//                 item: context
//                     .watch<ParkingManagementProvider>()
//                     .seatApprovalRequestModel!,
//               ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           context.watch<ParkingManagementProvider>().showRequestButton
//               ? Padding(
//                   padding: const EdgeInsets.all(4),
//                   child: InkWell(
//                     onTap: () async {
//                       Provider.of<ParkingManagementProvider>(context,
//                               listen: false)
//                           .sendRequestOpenPopupDialog(context: context);
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       color: HexColor(spaceManagementOrangeColor),
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Send Request',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(),
//           !context.watch<ParkingManagementProvider>().showRequestButton &&
//                   context.watch<ParkingManagementProvider>().showBookSpaceButton
//               ? Padding(
//                   padding: const EdgeInsets.all(4),
//                   child: InkWell(
//                     onTap: () async {
//                       int? seatConfigurationId =
//                           Provider.of<ParkingManagementProvider>(context,
//                                   listen: false)
//                               .bookSpaceSeatConfigurationId;
//                       if (seatConfigurationId == null) {
//                         showToastDialog(msg: somethingWentWrong);
//                         return;
//                       }

//                       Provider.of<ParkingManagementProvider>(context,
//                               listen: false)
//                           .openApprovedBookSeatScreen(
//                               context: context,
//                               seatConfigurationId: seatConfigurationId);
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       color: HexColor(spaceManagementOrangeColor),
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Book Parking',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }
// }
