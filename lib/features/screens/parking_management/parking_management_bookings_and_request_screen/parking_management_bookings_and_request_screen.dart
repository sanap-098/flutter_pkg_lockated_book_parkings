import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/tab_bar/common_tab_bar.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_bookings_and_request_screen/tabs/parking_management_bookings_tab.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_bookings_and_request_screen/tabs/parking_management_requests_tab.dart';

class ParkingManagementBookingsAndRequestScreen extends StatefulWidget {
  const ParkingManagementBookingsAndRequestScreen({Key? key}) : super(key: key);

  @override
  State<ParkingManagementBookingsAndRequestScreen> createState() =>
      _ParkingManagementBookingsAndRequestScreenState();
}

class _ParkingManagementBookingsAndRequestScreenState
    extends State<ParkingManagementBookingsAndRequestScreen> {
  List<Tab> statsTabs = [
    const Tab(
      child: Text("Bookings"),
    ),
    const Tab(
      child: Text("Requests"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Parking Management',
        leadingCallback: () {
          Navigator.popAndPushNamed(context, 'parking_management_screen');
        },
        actions: [
          InkWell(
            onTap: () {
              Navigator.popAndPushNamed(
                  context, 'parking_management_screen');
            },
            child: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CommonTabBar(tabs: statsTabs),
            const Expanded(
              child: TabBarView(
                children: [
                  ParkingManagementBookingsTab(),
                  ParkingManagementRequestsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/tab_bar/common_tab_bar.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_bookings_and_request_screen/tabs/parking_management_bookings_tab.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_bookings_and_request_screen/tabs/parking_management_requests_tab.dart';

// class ParkingManagementBookingsAndRequestScreen extends StatefulWidget {
//   const ParkingManagementBookingsAndRequestScreen({Key? key}) : super(key: key);

//   @override
//   State<ParkingManagementBookingsAndRequestScreen> createState() =>
//       _ParkingManagementBookingsAndRequestScreenState();
// }

// class _ParkingManagementBookingsAndRequestScreenState
//     extends State<ParkingManagementBookingsAndRequestScreen> {
//   List<Tab> statsTabs = [
//     const Tab(
//       child: Text("Bookings"),
//     ),
//     const Tab(
//       child: Text("Requests"),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   leading: InkWell(
//       //     onTap: () {
//       //       Navigator.popAndPushNamed(context, Routes.parkingManagementScreen);
//       //     },
//       //     child: const Icon(Icons.arrow_back),
//       //   ),
//       //   title: const Text(
//       //     'Parking Management',
//       //     style: TextStyle(
//       //       color: Colors.black,
//       //     ),
//       //   ),
//       //   actions: [
//       //     InkWell(
//       //       onTap: () {
//       //         Navigator.popAndPushNamed(
//       //             context, Routes.parkingManagementScreen);
//       //       },
//       //       child: const Icon(Icons.calendar_today),
//       //     ),
//       //   ],
//       // ),
//       appBar: CommonAppBar(
//         title: 'Parking Management',
//         leadingCallback: () {
//           Navigator.popAndPushNamed(context, Routes.parkingManagementScreen);
//         },
//         actions: [
//           InkWell(
//             onTap: () {
//               Navigator.popAndPushNamed(
//                   context, Routes.parkingManagementScreen);
//             },
//             child: const Icon(Icons.calendar_today),
//           ),
//         ],
//       ),
//       body: DefaultTabController(
//         length: 2,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             CommonTabBar(tabs: statsTabs),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 60, right: 60),
//             //   child: TabBar(
//             //     labelColor: HexColor(ticketTabColor),
//             //     unselectedLabelColor: Colors.black,
//             //     indicatorColor: HexColor(ticketTabColor),
//             //     tabs: const [
//             //       Tab(
//             //         text: 'Bookings',
//             //       ),
//             //       Tab(
//             //         text: 'Requests',
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             const Expanded(
//               child: TabBarView(
//                 children: [
//                   ParkingManagementBookingsTab(),
//                   ParkingManagementRequestsTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
