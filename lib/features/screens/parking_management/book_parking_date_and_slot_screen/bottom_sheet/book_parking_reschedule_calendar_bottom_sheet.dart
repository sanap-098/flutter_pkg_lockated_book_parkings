import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floor_model/floor_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_booked_seat_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_custom_calendar_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_fixed_booking_list_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_static_seat_booking_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_tower_floor_selection_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';




class BookParkingRescheduleCalendarBottomSheet extends StatefulWidget {
  const BookParkingRescheduleCalendarBottomSheet(
      {Key? key, required this.defaultDate, required this.parentContext})
      : super(key: key);

  final DateTime defaultDate;
  final BuildContext parentContext;

  @override
  State<BookParkingRescheduleCalendarBottomSheet> createState() =>
      _BookParkingRescheduleCalendarBottomSheetState();
}

class _BookParkingRescheduleCalendarBottomSheetState
    extends State<BookParkingRescheduleCalendarBottomSheet> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ParkingManagementFragmentProvider>(context, listen: false)
            .init(context: context, selectDate: widget.defaultDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent.withValues(alpha: 0.5),
        padding: const EdgeInsets.only(top: 40),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Consumer<ParkingManagementFragmentProvider>(
                          builder: (context, state, child) {
                            return Column(
                              children: [
                                const ParkingManagementCustomCalendarWidget(
                                  isForRescheduling: true,
                                ),
                                const ParkingManagementStaticSeatBookingWidget(),
                                if (!state.showApprovalRequestView &&
                                    state.selectedDateBookedSeats.isNotEmpty)
                                  ParkingManagementBookedSeatsWidget(
                                    seatBookigs: state.selectedDateBookedSeats,
                                    parentContext: context,
                                    isForRescheduling: true,
                                  ),
                                if (!state.isSelectedDateBefore &&
                                    state.selectedDateBookedSeats.isEmpty)
                                  ParkingManagementTowerFloorSelectionWidget(
                                    building: state.buildings,
                                    floors: state.floors,
                                    buildingName: state.buildingName,
                                    floorName: state.floorName,
                                    isForRescheduling: true,
                                  ),
                                if (!state.isSelectedDateBefore &&
                                    state.selectedDateBookedSeats.isEmpty)
                                  const ParkingManagementFixedBookingListWidget(
                                    isForRescheduling: true,
                                  ),
                                // SizedBox(
                                //   height: 500,
                                // ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (Provider.of<ParkingManagementFragmentProvider>(context,
                        listen: true)
                    .showNextButton &&
                Provider.of<ParkingManagementFragmentProvider>(context,
                        listen: true)
                    .selectedDateBookedSeats
                    .isEmpty)
              Positioned(
                bottom: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    BuildingModel? building;
                    FloorModel? floor;
                    if (Provider.of<ParkingManagementFragmentProvider>(
                            widget.parentContext,
                            listen: false)
                        .buildings
                        .isNotEmpty) {
                      for (var item
                          in Provider.of<ParkingManagementFragmentProvider>(
                                  widget.parentContext,
                                  listen: false)
                              .buildings) {
                        if (item.id ==
                            Provider.of<ParkingManagementFragmentProvider>(
                                    widget.parentContext,
                                    listen: false)
                                .buildingId) {
                          building = item;
                        }
                      }
                      if (building == null) {
                        building = BuildingModel(
                            id: Provider.of<ParkingManagementFragmentProvider>(
                                    widget.parentContext,
                                    listen: false)
                                .buildingId,
                            name:
                                Provider.of<ParkingManagementFragmentProvider>(
                                        widget.parentContext,
                                        listen: false)
                                    .buildingName);
                      }
                    } else {
                      building = BuildingModel(
                          id: Provider.of<ParkingManagementFragmentProvider>(
                                  widget.parentContext,
                                  listen: false)
                              .buildingId,
                          name: Provider.of<ParkingManagementFragmentProvider>(
                                  widget.parentContext,
                                  listen: false)
                              .buildingName);
                    }

                    if (Provider.of<ParkingManagementFragmentProvider>(
                            widget.parentContext,
                            listen: false)
                        .floors
                        .isNotEmpty) {
                      for (var item
                          in Provider.of<ParkingManagementFragmentProvider>(
                                  widget.parentContext,
                                  listen: false)
                              .floors) {
                        if (item.id ==
                            Provider.of<ParkingManagementFragmentProvider>(
                                    widget.parentContext,
                                    listen: false)
                                .floorId) {
                          floor = item;
                        }
                      }
                      if (floor == null) {
                        floor = FloorModel(
                            id: Provider.of<ParkingManagementFragmentProvider>(
                                    widget.parentContext,
                                    listen: false)
                                .floorId,
                            name:
                                Provider.of<ParkingManagementFragmentProvider>(
                                        widget.parentContext,
                                        listen: false)
                                    .floorName);
                      }
                    } else {
                      floor = FloorModel(
                          id: Provider.of<ParkingManagementFragmentProvider>(
                                  widget.parentContext,
                                  listen: false)
                              .floorId,
                          name: Provider.of<ParkingManagementFragmentProvider>(
                                  widget.parentContext,
                                  listen: false)
                              .floorName);
                    }
                    Provider.of<BookParkingDateAndSlotProvider>(
                            widget.parentContext,
                            listen: false)
                        .handleDateSelectionFromFragment(
                            widget.parentContext,
                            Provider.of<ParkingManagementFragmentProvider>(
                                    widget.parentContext,
                                    listen: false)
                                .selectedDay,
                            building,
                            floor);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: HexColor(spaceManagementMainButtonColor),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
