import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_number_model/parking_number_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';




class BookParkingSelectionOveriddenDialog extends StatelessWidget {
  const BookParkingSelectionOveriddenDialog({Key? key, required this.item})
      : super(key: key);
  final ParkingNumberModel item;
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
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Select only 1 parking or else your previous selection will be overidden. Do you want to proceed?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                    Provider.of<BookParkingDateAndSlotProvider>(context,
                            listen: false)
                        .onSlotSeatSelected(seat: item);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor(newUiPrimaryBlue),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
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
