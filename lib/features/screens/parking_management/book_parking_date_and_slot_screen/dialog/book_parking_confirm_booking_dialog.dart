import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_slot_model/parking_slot_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_number_model/parking_number_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';


class BookParkingConfirmBookingDialog extends StatelessWidget {
  // final PostBookingRequestModel request;
  final String categoryName;
  final String bookingDate;
  final String parkingConfigurationId;
  final String parkingTimeSlotId;
  final String parkingNumberId;
  final BuildContext parentContext;
  final bool isForRescheduling;
  final ParkingSlotModel selectedParkingSlotModel;
  final ParkingNumberModel? selectParkingNumberModel;

  const BookParkingConfirmBookingDialog({
    Key? key,
    // required this.request,
    required this.categoryName,
    required this.parentContext,
    this.isForRescheduling = false,
    required this.bookingDate,
    required this.parkingConfigurationId,
    required this.parkingTimeSlotId,
    required this.parkingNumberId,
    required this.selectedParkingSlotModel,
    this.selectParkingNumberModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Booking Confirmation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTitleValueWidget(
                        title: 'Date',
                        value: '',
                        isDate: true,
                        selectedDate: bookingDate,
                      ),
                    ),
                    Expanded(
                      child: _buildTitleValueWidget(
                        title: 'Parking Type',
                        value: categoryName,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildTitleValueWidget(
                        title: 'Time Slot',
                        value: selectedParkingSlotModel.amPm ?? '',
                      ),
                    ),
                    Expanded(
                      child: _buildTitleValueWidget(
                        title: 'Parking No.',
                        value: selectParkingNumberModel?.name ?? '',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: HexColor(spaceManagementOrangeColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Provider.of<BookParkingDateAndSlotProvider>(parentContext,
                              listen: false)
                          .postSeatBookingRequest(
                        context: parentContext,
                        isForRescheduling: isForRescheduling,
                        bookingDate: bookingDate,
                        parkingConfigurationId: parkingConfigurationId,
                        parkingNumberId: parkingNumberId,
                        parkingTimeSlotId: parkingTimeSlotId,
                      );
                    },
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                        color: HexColor(spaceManagementMainButtonColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleValueWidget({
    required String title,
    required String value,
    bool isDate = false,
    String? selectedDate,
  }) {
    String date = '';
    if (isDate) {
      DateTime tempDate = DateFormat('dd/MM/yyyy').parse(selectedDate!);
      date = DateFormat('EEE, MMM dd, yyyy').format(tempDate);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            isDate ? date : value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
