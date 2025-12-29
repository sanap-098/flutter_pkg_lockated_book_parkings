import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../../models/parking_booking/parking_booking_schedules/parking_booking_schedules_slot_model/parking_booking_schedules_slot_model.dart';
import '../../../../providers/parking_booking/parking_booking_create_provider.dart';


class BookParkingTimeSlotListItemWidget extends StatelessWidget {
  final ParkingBookingSchedulesSlotModel item;

  const BookParkingTimeSlotListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context
            .read<ParkingBookingCreateProvider>()
            .onTimeSlotChanged(value: item);
        //   if (!item.isSelectedBeforeBooking) {
        //     Provider.of<BookSpaceDateAndSlotProvider>(context, listen: false)
        //         .onSlotChanged(slot: item);
        //   } else {
        //     showToastDialog(msg: 'Cant reschedule with same slot again.');
        //   }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
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
