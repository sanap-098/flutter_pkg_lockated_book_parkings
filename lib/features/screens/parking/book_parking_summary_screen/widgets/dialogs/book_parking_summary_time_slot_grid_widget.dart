import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/parking_booking/parking_booking_create_provider.dart';
import 'book_parking_summary_time_slot_grid_item_widget.dart';

class BookParkingSummaryTimeSlotGridWidget extends StatelessWidget {
  const BookParkingSummaryTimeSlotGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio:
              (((MediaQuery.of(context).size.width - 16) / 2) / 30),
        ),
        itemCount:
            context.read<ParkingBookingCreateProvider>().selectedSlots.length,
        itemBuilder: (context, index) {
          final item =
              context.read<ParkingBookingCreateProvider>().selectedSlots[index];
          return BookParkingSummaryTimeSlotGridItemWidget(item: item);
        },
      ),
    );
  }
}
