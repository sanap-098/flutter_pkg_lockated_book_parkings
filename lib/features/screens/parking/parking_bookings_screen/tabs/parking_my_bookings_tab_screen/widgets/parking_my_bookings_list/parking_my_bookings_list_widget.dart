import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/tabs/parking_my_bookings_tab_screen/widgets/parking_my_bookings_list/parking_my_bookings_list_item_widget.dart';

import '../../../../../../../models/parking_booking/parking_bookings/parking_bookings_model/parking_bookings_model.dart';

class ParkingMyBookingsListWidget extends StatelessWidget {
  final List<ParkingBookingsModel> myBookings;
  final bool? isExpired;
  const ParkingMyBookingsListWidget(
      {super.key, required this.myBookings, this.isExpired});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // reverse: true,
        itemCount: myBookings.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = myBookings[index];
          return ParkingMyBookingsListItemWidget(
            item: item,
            isExpired: isExpired ?? false,
          );
          // return parkingListItem(
          //     isExpired: index > 0, isBikeIcon: index % 2 != 0, context: context);
        },
      ),
    );
  }
}
