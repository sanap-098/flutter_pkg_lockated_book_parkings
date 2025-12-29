import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ParkingManagementRoasterWidget extends StatelessWidget {
  final int bookedDaysPerWeek;
  final int totalBookingDaysPerWeek;
  final String roasterType;

  const ParkingManagementRoasterWidget(
      {Key? key,
      required this.bookedDaysPerWeek,
      required this.totalBookingDaysPerWeek,
      required this.roasterType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor('#FFF3C5'),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
                '$bookedDaysPerWeek of $totalBookingDaysPerWeek  days used for the $roasterType'),
          ),
        ),
      ),
    );
  }
}
