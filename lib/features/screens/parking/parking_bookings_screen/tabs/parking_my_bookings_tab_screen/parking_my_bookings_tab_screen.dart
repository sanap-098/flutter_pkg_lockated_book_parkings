import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/tabs/parking_my_bookings_tab_screen/widgets/parking_my_bookings_list/parking_my_bookings_list_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/parking_booking/parking_booking_provider.dart';

class ParkingMyBookingsTabScreen extends StatelessWidget {
  const ParkingMyBookingsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingBookingProvider>(
      builder: (context, state, child) {
        return Column(
          children: [
            state.isLoading
                ? const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : state.myBookings.isNotEmpty
                    ? ParkingMyBookingsListWidget(
                        myBookings: state.myBookings,
                      )
                    : const Expanded(
                        child: Center(
                          child: Text('No Data Available'),
                        ),
                      )
          ],
        );
      },
    );
  }
}
