import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/image_card_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../../../../../../models/parking_booking/parking_bookings/parking_bookings_model/parking_bookings_model.dart';

class ParkingShowQrCodeDialog extends StatelessWidget {
  final ParkingBookingsModel item;
  const ParkingShowQrCodeDialog({super.key, required this.item});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          Text(
            // 'Booking ID - 13Jun_T3_B1/15',
            'Booking ID - ${item.id}',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: HexColor('262626')),
          ),
          const SizedBox(
            height: 15,
          ),
          if (item.qrCodeUrl != null && item.qrCodeUrl!.isNotEmpty)
            ImageCardWidget(image: item.qrCodeUrl, height: 200, width: 200),
          // QrImage(
          //   padding: EdgeInsets.zero,
          //   data: 'Booking ID - 13Jun_T3_B1/15',
          //   version: QrVersions.auto,
          //   size: 200,
          // ),
          const SizedBox(
            height: 15,
          ),
          buildKVPair(title: 'Tower', value: item.buildingName ?? "NA"),
          buildKVPair(title: 'Floor', value: item.floorName ?? 'NA'),
          buildKVPair(
              title: 'Slot', value: item.showSchedule?.parkingNumber ?? "NA"),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget buildKVPair({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                value,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
