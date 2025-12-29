import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

// Models
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_floor_model/parking_booking_floor_model.dart';

// Providers
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';

// Utils & Themes
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';

class BookParkingCalendarFloorSelectionDialog extends StatelessWidget {
  final BuildContext parentContext;
  final List<ParkingBookingFloorModel> floors;

  const BookParkingCalendarFloorSelectionDialog({
    Key? key,
    required this.parentContext,
    required this.floors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Floors',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                height: 1,
                color: Colors.black,
              ),
              _floorsListWidget(floors: floors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floorsListWidget({required List<ParkingBookingFloorModel> floors}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Floors',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: HexColor(spaceManagementOrangeColor),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Available parkings',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: HexColor(spaceManagementOrangeColor),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: floors.length,
              itemBuilder: (context, index) {
                final item = floors[index];
                if (item.configurationId == null ||
                    item.configurationId!.toString().isEmpty) {
                  return Container();
                }
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    parentContext
                        .read<ParkingBookingCreateProvider>()
                        .onFloorChanged(
                          value: item,
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.availableParkings != null
                                ? item.availableParkings.toString()
                                : '0',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
