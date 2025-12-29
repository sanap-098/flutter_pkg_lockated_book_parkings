import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';



class BookParkingCategoryBottomSheet extends StatefulWidget {
  final String buildingId;
  final String floorId;
  final BuildContext parentContext;

  const BookParkingCategoryBottomSheet({
    Key? key,
    required this.buildingId,
    required this.floorId,
    required this.parentContext,
  }) : super(key: key);

  @override
  State<BookParkingCategoryBottomSheet> createState() =>
      _BookParkingCategoryBottomSheetState();
}

class _BookParkingCategoryBottomSheetState
    extends State<BookParkingCategoryBottomSheet> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookParkingDateAndSlotProvider>(context, listen: false)
          .initCategoryBottomSheet(
        context: context,
        buildingId: widget.buildingId,
        floorId: widget.floorId,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookParkingDateAndSlotProvider>(
        builder: (context, state, child) {
      return state.isCategoryBottomSheetSeatConfigurationLoading
          ? const CircularProgressIndicator()
          : state.categoryBottomSheetSeatConfigurationErrorMsg.isNotEmpty
              ? Text(state.categoryBottomSheetSeatConfigurationErrorMsg)
              : state.categoryBottomSheetSeatConfigurations.isNotEmpty
                  ? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListView.builder(
                          itemCount: state
                              .categoryBottomSheetSeatConfigurations.length,
                          itemBuilder: (context, index) {
                            final item = state
                                .categoryBottomSheetSeatConfigurations[index];
                            return _buildListItem(item: item);
                          },
                        ),
                      ),
                    )
                  : const Text('No Data Available!');
    });
  }

  Widget _buildListItem({required ParkingSeatConfigurationDetailModel item}) {
    String assetsImage = 'assets/space_management/seat_category_images/';
    String assetsName = 'default_cabin_big';
    switch (item.parkingCategory ?? '') {
      case 'Cabin':
        assetsName = 'static_cabin';
        break;
      case 'Fixed desk':
        assetsName = 'static_fixed_desk';
        break;
      case 'Fixed':
        assetsName = 'static_fixed_desk';
        break;
      case 'Flexi desk':
        assetsName = 'static_flexi_desk';
        break;
      case 'hot desk':
        assetsName = 'static_hot_desk';
        break;
      case 'Linear WS':
        assetsName = 'static_linear_ws';
        break;
      case 'Linear':
        assetsName = 'static_linear_ws';
        break;
      case 'Angular WS':
        assetsName = 'static_angular_ws1';
        break;
      case 'Angular':
        assetsName = 'static_angular';
        break;
      case 'Common':
        assetsName = 'static_common1';
        break;
      default:
    }

    if (item.parkingImageUrl != null) {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
          Provider.of<BookParkingDateAndSlotProvider>(widget.parentContext,
                  listen: false)
              .getSelectedConfiguration(
                  seatConfigurationDetailModel: item,
                  parentContext: widget.parentContext);
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                item.parkingImageUrl!,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 200,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  item.parkingCategory ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
          Provider.of<BookParkingDateAndSlotProvider>(widget.parentContext,
                  listen: false)
              .getSelectedConfiguration(
                  seatConfigurationDetailModel: item,
                  parentContext: widget.parentContext);
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                '$assetsImage$assetsName.png',
                width: double.infinity,
                fit: BoxFit.fill,
                height: 200,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  item.parkingCategory ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
