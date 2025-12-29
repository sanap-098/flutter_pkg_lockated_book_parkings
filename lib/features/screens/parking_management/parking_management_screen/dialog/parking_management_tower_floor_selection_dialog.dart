import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';



class ParkingManagementTowerFloorSelectionDialog extends StatelessWidget {
  final BuildContext parentContext;
  final bool isFloor;
  final bool isForRescheduling;

  const ParkingManagementTowerFloorSelectionDialog({
    Key? key,
    required this.parentContext,
    this.isFloor = false,
    this.isForRescheduling = false,
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
                    Text(
                      isFloor ? 'Floors' : 'Towers',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
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
              if (isFloor == false &&
                  isForRescheduling == false &&
                  Provider.of<ParkingManagementProvider>(context, listen: true)
                      .buildings
                      .isNotEmpty)
                _buildingListWidget(
                    buildings: Provider.of<ParkingManagementProvider>(context,
                            listen: true)
                        .buildings),
              if (isFloor &&
                  isForRescheduling == false &&
                  Provider.of<ParkingManagementProvider>(context, listen: true)
                      .floors
                      .isNotEmpty)
                _floorsListWidget(
                    floors: Provider.of<ParkingManagementProvider>(context,
                            listen: true)
                        .floors),
              //Building and Floor for Rescheduling
              if (isFloor == false &&
                  isForRescheduling &&
                  Provider.of<ParkingManagementFragmentProvider>(context,
                          listen: true)
                      .buildings
                      .isNotEmpty)
                _buildingListWidget(
                    buildings: Provider.of<ParkingManagementFragmentProvider>(
                            context,
                            listen: true)
                        .buildings),
              if (isFloor &&
                  isForRescheduling &&
                  Provider.of<ParkingManagementFragmentProvider>(context,
                          listen: true)
                      .floors
                      .isNotEmpty)
                _floorsListWidget(
                    floors: Provider.of<ParkingManagementFragmentProvider>(
                            context,
                            listen: true)
                        .floors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildingListWidget({required List<BuildingModel> buildings}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Towers',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: HexColor(spaceManagementOrangeColor),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Available Parkings',
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
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                final item = buildings[index];
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    if (isForRescheduling) {
                      Provider.of<ParkingManagementFragmentProvider>(
                              parentContext,
                              listen: false)
                          .buildingSelected(
                              context: parentContext, building: item);
                    } else {
                      Provider.of<ParkingManagementProvider>(parentContext,
                              listen: false)
                          .buildingSelected(
                              context: parentContext, building: item);
                    }
                  },
                  child: _buildingItemWidget(building: item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildingItemWidget({required BuildingModel building}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              building.name ?? '',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              building.availableParkings != null
                  ? building.availableParkings.toString()
                  : '0',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floorsListWidget({required List<FloorModel> floors}) {
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
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    if (isForRescheduling) {
                      Provider.of<ParkingManagementFragmentProvider>(
                              parentContext,
                              listen: false)
                          .floorSelected(context: parentContext, floor: item);
                    } else {
                      Provider.of<ParkingManagementProvider>(parentContext,
                              listen: false)
                          .floorSelected(context: parentContext, floor: item);
                    }
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
