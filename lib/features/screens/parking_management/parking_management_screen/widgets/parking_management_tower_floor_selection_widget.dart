import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Models
import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';

// Providers
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';

// Widgets
// Note: Ensure this widget file exists at this path or update accordingly if it was moved to common/widgets
import 'package:flutter_pkg_lockated_book_parking/widgets/common/building_and_floor_text_tile.dart'; 
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/dialog/parking_management_tower_floor_selection_dialog.dart';

class ParkingManagementTowerFloorSelectionWidget extends StatelessWidget {
  final List<BuildingModel> building;
  final List<FloorModel> floors;
  final String buildingName;
  final String floorName;
  final bool isForRescheduling;

  const ParkingManagementTowerFloorSelectionWidget({
    Key? key,
    required this.building,
    required this.floors,
    required this.buildingName,
    required this.floorName,
    this.isForRescheduling = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          BuildAndFloorTextTile(
            title: buildingName.isEmpty ? 'Select Building' : buildingName,
            onTap: () async {
              await showDialog(
                context: context,
                builder: (_) {
                  return ParkingManagementTowerFloorSelectionDialog(
                    parentContext: context,
                    isForRescheduling: isForRescheduling,
                  );
                },
              );
            },
          ),
          const SizedBox(
            width: 15,
          ),
          BuildAndFloorTextTile(
            title: floorName.isEmpty ? 'Select Floor' : floorName,
            onTap: () async {
              if (floors.isEmpty) {
                final res = await Provider.of<ParkingManagementProvider>(
                        context,
                        listen: false)
                    .getFloorsList(
                        context: context,
                        buildingId: Provider.of<ParkingManagementProvider>(
                                context,
                                listen: false)
                            .buildingId,
                        selectedDate: Provider.of<ParkingManagementProvider>(
                                context,
                                listen: false)
                            .selectedDay);
                if (res) {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return ParkingManagementTowerFloorSelectionDialog(
                        parentContext: context,
                        isFloor: true,
                        isForRescheduling: isForRescheduling,
                      );
                    },
                  );
                }
              } else {
                await showDialog(
                  context: context,
                  builder: (_) {
                    return ParkingManagementTowerFloorSelectionDialog(
                      parentContext: context,
                      isFloor: true,
                      isForRescheduling: isForRescheduling,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
