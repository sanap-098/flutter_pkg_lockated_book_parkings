import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_number_model/parking_number_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/widgets/book_parking_slot_seat_item_widget.dart';


class BookParkingSlotSeatListWidget extends StatelessWidget {
  final List<ParkingNumberModel> seatDetails;
  final String? floorAttachment;

  BookParkingSlotSeatListWidget(
      {Key? key, required this.seatDetails, this.floorAttachment})
      : super(key: key);

  final searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookParkingDateAndSlotProvider>(
      builder: (context, state, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (floorAttachment == null) {
                      showToastDialog(msg: 'No floor plan attached.');
                    } else {
                       Navigator.pushNamed(context, 'web_view_screen',
                          arguments: floorAttachment);
                      // Navigator.pushNamed(context, Routes.webViewScreen,
                      //     arguments: floorAttachment);
                    }
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Parking No.',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 18,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.search,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SizedBox(
                            width: 110,
                            child: TextField(
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Search Parking No.',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onChanged: (value) {
                                Provider.of<BookParkingDateAndSlotProvider>(
                                        context,
                                        listen: false)
                                    .onSearched(input: value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio:
                        (((MediaQuery.of(context).size.width - 16) / 2) / 60)),
                itemCount: state.filteredSeatDetailsList.isEmpty
                    ? seatDetails.length
                    : state.filteredSeatDetailsList.length,
                itemBuilder: (context, index) {
                  final item = state.filteredSeatDetailsList.isEmpty
                      ? seatDetails[index]
                      : state.filteredSeatDetailsList[index];
                  return BookParkingSlotSeatItemWidget(item: item);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
