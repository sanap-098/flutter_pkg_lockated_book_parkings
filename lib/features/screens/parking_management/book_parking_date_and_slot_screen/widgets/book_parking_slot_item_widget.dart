import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_slot_model/parking_slot_model.dart';


class BookParkingSlotItemWidget extends StatelessWidget {
  final ParkingSlotModel item;

  const BookParkingSlotItemWidget({Key? key, required this.item})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!item.isSelectedBeforeBooking) {
          Provider.of<BookParkingDateAndSlotProvider>(context, listen: false)
              .onSlotChanged(slot: item);
        } else {
          showToastDialog(msg: 'Cant reschedule with same slot again.');
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: HexColor(item.isSelected
                ? calendarBlue
                : bookSpaceDateAndSlotsNewUiFieldbgColor),
            border: Border.all(
              color: item.isSelected
                  ? HexColor(spaceManagementOrangeColor)
                  : Colors.white,
            )),
        child: Center(
            child: Text(
          item.amPm ?? '',
          style: TextStyle(
            color: item.isSelectedBeforeBooking ? Colors.grey : Colors.black,
          ),
        )),
      ),
    );
  }
}
