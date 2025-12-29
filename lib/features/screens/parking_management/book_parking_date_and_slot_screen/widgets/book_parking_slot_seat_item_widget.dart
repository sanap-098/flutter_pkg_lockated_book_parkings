import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_number_model/parking_number_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/dialog/book_parking_selection_overidden_dialog.dart';


class BookParkingSlotSeatItemWidget extends StatelessWidget {
  final ParkingNumberModel item;

  const BookParkingSlotSeatItemWidget({Key? key, required this.item})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          bool tempIsSelected = false;
          for (var seat in Provider.of<BookParkingDateAndSlotProvider>(context,
                  listen: false)
              .seatDetailsList) {
            if (seat.isSelected) {
              tempIsSelected = true;
            }
          }
          for (var seat in Provider.of<BookParkingDateAndSlotProvider>(context,
                  listen: false)
              .filteredSeatDetailsList) {
            if (seat.isSelected) {
              tempIsSelected = true;
            }
          }
          if (tempIsSelected) {
            await showDialog(
                context: context,
                builder: (context) {
                  return BookParkingSelectionOveriddenDialog(
                    item: item,
                  );
                });
          } else {
            // logInfo(msg: 'gere');
            Provider.of<BookParkingDateAndSlotProvider>(context, listen: false)
                .onSlotSeatSelected(seat: item);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: HexColor(calendarBlue),
            border: Border.all(
              color: item.isSelected
                  ? HexColor(spaceManagementOrangeColor)
                  : Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(item.name ?? ''),
          ),
        ),
      ),
    );
  }
}
