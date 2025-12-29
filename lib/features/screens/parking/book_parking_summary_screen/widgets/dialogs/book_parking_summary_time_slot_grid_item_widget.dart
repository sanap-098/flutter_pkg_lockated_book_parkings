import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../models/parking_booking/parking_booking_schedules/parking_booking_schedules_slot_model/parking_booking_schedules_slot_model.dart';


class BookParkingSummaryTimeSlotGridItemWidget extends StatelessWidget {
  final ParkingBookingSchedulesSlotModel item;

  const BookParkingSummaryTimeSlotGridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: HexColor(item.isSelected
              ? spaceManagementOrangeColor
              : calendarBlue),
          border: Border.all(
            color: item.isSelected
                ? HexColor(spaceManagementOrangeColor)
                : Colors.white,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Center(
              child: Text(
            item.ampm ?? '',
            style:  TextStyle(
              // color: Colors.black
                color: item.isSelected ? Colors.white : Colors.black,
                ),
          )),
        ),
      ),
    );
  }
}