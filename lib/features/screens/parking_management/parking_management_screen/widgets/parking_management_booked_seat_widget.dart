import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_booked_seats_item_widget.dart';

class ParkingManagementBookedSeatsWidget extends StatelessWidget {
  final List<ParkingSeatBooking> seatBookigs;
  final BuildContext parentContext;
  final bool isForRescheduling;

  const ParkingManagementBookedSeatsWidget(
      {Key? key,
      required this.seatBookigs,
      required this.parentContext,
      this.isForRescheduling = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text('Bookings'),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: seatBookigs.length,
          itemBuilder: (context, index) {
            final item = seatBookigs[index];
            return ParkingManagementBookedSeatsItemWidget(
                item: item,
                parentContext: parentContext,
                isForRescheduling: isForRescheduling);
          },
        ),
      ],
    );
  }
}
