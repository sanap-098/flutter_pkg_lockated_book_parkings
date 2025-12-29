import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_model/parking_seat_approval_request_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_requests_tab_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/space_management_utils.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_card.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';

class ParkingManagementSeatApprovalRequestWidget extends StatelessWidget {
  final ParkingSeatApprovalRequestModel item;

  const ParkingManagementSeatApprovalRequestWidget(
      {Key? key, required this.item})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      labelColor: HexColor(_lableBackgroundColor(status: item.status ?? '')),
      labelText: item.status ?? '',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(categoryName: item.parkingCategory ?? ''),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.parkingCategory ?? 'Hot Desk',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Requested On : ',
                      style: TextStyle(color: HexColor(appBlue), fontSize: 12),
                    ),
                    Text(
                      Utils.parseToSimpleDateFormat(
                          date: item.createdAt ?? '21/7/2021'),
                      style: TextStyle(color: HexColor(appBlue), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage({required String categoryName}) {
    String tempAssetImage = 'default_cabin';
    switch (categoryName) {
      case 'Cabin':
        tempAssetImage = 'static_cabin_small';
        break;
      case 'Fixed desk':
        tempAssetImage = 'static_fixed_desk_small';
        break;
      case 'Fixed':
        tempAssetImage = 'static_fixed_desk_small';
        break;
      case 'Flexi desk':
        tempAssetImage = 'static_flexi_desk_small';
        break;
      case 'hot desk':
        tempAssetImage = 'static_hot_desk_small';
        break;
      default:
    }
    return Image.asset(
      'assets/space_management/seat_category_images/$tempAssetImage.png',
      width: 100,
      height: 100,
    );
  }

  String _lableBackgroundColor({required String status}) {
    String tempColor = newUiPrimaryBlue;
    String tempStatus = status.trim().toUpperCase();
    switch (tempStatus) {
      case 'APPROVED':
        tempColor = lightGreenStatusColor;
        break;
      case 'REJECTED':
        tempColor = lightRedStatusColor;
        break;
      case 'PENDING':
        tempColor = spaceManagementOrangeColor;
        break;
      default:
    }
    return tempColor;
  }
}
