import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/tabs/parking_cancelled_tab_screen/parking_cancelled_tab_screen.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/tab_bar/common_tab_bar.dart';
import 'package:provider/provider.dart';

import '../../../providers/parking_booking/parking_booking_provider.dart';
import 'tabs/parking_my_bookings_tab_screen/parking_my_bookings_tab_screen.dart';

class ParkingBookingsScreen extends StatefulWidget {
  const ParkingBookingsScreen({super.key});

  @override
  State<ParkingBookingsScreen> createState() => _ParkingBookingsScreenState();
}

class _ParkingBookingsScreenState extends State<ParkingBookingsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ParkingBookingProvider>(context, listen: false)
            .init(context: context));
    super.initState();
  }

  List<Tab> statsTabs = [
    const Tab(
      child: Text("My Bookings"),
    ),
    const Tab(
      child: Text("Cancelled"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // length: 3,
      // length: 2,
      length: statsTabs.length,
      // initialIndex: initialIndex ?? 0,
      child: Scaffold(
        appBar: const CommonAppBar(
          title: 'Parking Management',
        ),
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   centerTitle: true,
        //   leading: InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Icon(Icons.arrow_back_ios),
        //   ),
        //   title: const Text(
        //     'Parking Management',
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   bottom: TabBar(
        //     isScrollable: true,
        //     labelColor: HexColor(ticketTabColor),
        //     unselectedLabelColor: Colors.grey,
        //     indicatorColor: HexColor(ticketTabColor),
        //     tabs: const [
        //       Tab(
        //         text: 'My Bookings',
        //       ),
        //       Tab(
        //         text: 'Cancelled',
        //       ),
        //     ],
        //   ),
        // ),
        body: Column(
          children: [
            CommonTabBar(tabs: statsTabs),
            const Expanded(
              child: TabBarView(
                children: [
                  ParkingMyBookingsTabScreen(),
                  ParkingCancelledTabScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
