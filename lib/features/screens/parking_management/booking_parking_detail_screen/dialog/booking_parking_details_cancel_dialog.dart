import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/booking_parking_detail_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';

class BookingParkingDetailsCancelDialog extends StatelessWidget {
  final BuildContext parentContext;
  final String cancelledById;
  final String bookingId;

  const BookingParkingDetailsCancelDialog(
      {Key? key,
      required this.parentContext,
      required this.cancelledById,
      required this.bookingId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Do you really want to Cancel the Booking?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor(lightRedStatusColor),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'NO',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<BookingParkingDetailProvider>(parentContext,
                            listen: false)
                        .onCancelConfirmClicked(
                            parentContext: parentContext,
                            bookingId: bookingId,
                            cancelledById: cancelledById);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor(newUiPrimaryBlue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'YES',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
