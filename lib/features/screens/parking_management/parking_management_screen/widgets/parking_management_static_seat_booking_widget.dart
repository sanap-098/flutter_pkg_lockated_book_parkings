

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_model/parking_seat_configuration_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';



class ParkingManagementStaticSeatBookingWidget extends StatelessWidget {
  const ParkingManagementStaticSeatBookingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor(calendarBlue),
              border: Border.all(color: HexColor(seatBookingBorder))),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text('Parking Slot Booking'),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
