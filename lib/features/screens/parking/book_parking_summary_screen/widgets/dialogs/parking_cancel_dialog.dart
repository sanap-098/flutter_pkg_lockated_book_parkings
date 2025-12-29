import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/parking_booking/parking_booking_provider.dart';

class ParkingCancelDialog extends StatelessWidget {
  final String parkingId;
  final BuildContext parentContext;
  const ParkingCancelDialog(
      {super.key, required this.parkingId, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Are you sure you want to cancel parking reservation process?',
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: TextButton(
                      onPressed: () async {
                        // Navigator.pop(context, true);
                        await context
                            .read<ParkingBookingProvider>()
                            .cancelParkingBooking(
                                parkingId: parkingId,
                                parentContext: parentContext)
                            .then((value) {
                          if (value != null && value as bool == true) {
                            Navigator.pop(context);
                            parentContext
                                .read<ParkingBookingProvider>()
                                .init(context: parentContext);
                          }
                        });
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.black),
                      ))),
              Container(
                height: 30,
                color: Colors.grey,
                width: 1,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
