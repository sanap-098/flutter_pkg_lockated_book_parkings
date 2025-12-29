import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_slot_model/parking_slot_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/widgets/book_parking_slot_item_widget.dart';


class BookParkingSlotListWidget extends StatelessWidget {
  final List<ParkingSlotModel> slotsList;

  const BookParkingSlotListWidget({Key? key, required this.slotsList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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
                childAspectRatio:
                    (((MediaQuery.of(context).size.width - 16) / 2) / 30)),
            itemCount: slotsList.length,
            itemBuilder: (context, index) {
              final item = slotsList[index];
              return BookParkingSlotItemWidget(item: item);
            },
          ),
        ),
      ],
    );
  }
}
