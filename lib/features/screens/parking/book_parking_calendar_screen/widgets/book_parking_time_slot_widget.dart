import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/parking_booking/parking_booking_schedules/parking_booking_schedules_slot_model/parking_booking_schedules_slot_model.dart';
import '../../../../providers/parking_booking/parking_booking_create_provider.dart';
import 'book_parking_time_slot_list_item_widget.dart';

class BookParkingTimeSlotWidget extends StatelessWidget {
  final List<ParkingBookingSchedulesSlotModel> slots;
  const BookParkingTimeSlotWidget({super.key, required this.slots});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Time Slot',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio:
                    (((MediaQuery.of(context).size.width - 16) / 2) / 30)),
            itemCount: context.read<ParkingBookingCreateProvider>().slots.length,
            itemBuilder: (context, index) {
              final item = context.read<ParkingBookingCreateProvider>().slots[index];
              return BookParkingTimeSlotListItemWidget(item: item);
            },
          ),
        ),
      ],
    );
  }
}