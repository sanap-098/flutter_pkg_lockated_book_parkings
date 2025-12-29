import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/book_parking_date_and_slot_route_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/building_and_floor_text_tile.dart'; 
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/bottom_sheet/book_parking_category_bottom_sheet.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/bottom_sheet/book_parking_reschedule_calendar_bottom_sheet.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/widgets/book_parking_slot_list_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/widgets/book_parking_slot_seat_list_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/widgets/book_parking_terms_widget.dart';
import 'package:provider/provider.dart';



class BookParkingDateAndSlotScreen extends StatefulWidget {
  const BookParkingDateAndSlotScreen(
      {Key? key, required this.routeModel, this.isFromNoti = false})
      : super(key: key);

  final BookParkingDateAndSlotRouteModel routeModel;
  final bool isFromNoti;

  @override
  State<BookParkingDateAndSlotScreen> createState() =>
      _BookParkingDateAndSlotScreenState();
}

class _BookParkingDateAndSlotScreenState
    extends State<BookParkingDateAndSlotScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookParkingDateAndSlotProvider>(context, listen: false).init(
        context: context,
        seatConfigurationModel: widget.routeModel.seatConfiguration,
        selectDay: widget.routeModel.selectDay,
        buildingModel: widget.routeModel.building,
        floorModel: widget.routeModel.floor,
        isForRescheduling: widget.routeModel.isForRescheduling,
        seatBooking: widget.routeModel.mSeatBooking as dynamic
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isFromNoti) {
          Navigator.pushNamedAndRemoveUntil(
              context, 'home_screen', (route) => false);
          // Navigator.pushNamedAndRemoveUntil(
          //     context, Routes.homeScreen, (route) => false);
        } else {
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        appBar: CommonAppBar(title: widget.routeModel.isForRescheduling
                ? 'Reschedule'
                : 'Book Parking Slot',),
        // appBar: AppBar(
        //   title: Text(
        //     widget.routeModel.isForRescheduling
        //         ? 'Reschedule'
        //         : 'Book Parking Slot',
        //     style: const TextStyle(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        body: Consumer<BookParkingDateAndSlotProvider>(
          builder: (context, state, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.seatConfiguration != null)
                    _buildHeaderImage(
                      seatImageUrl: state.seatConfiguration!.parkingImageUrl,
                      categoryName: state.seatConfiguration!.parkingCategory,
                    ),
                  if (state.mSeatBooking != null)
                    _buildHeaderImage(
                      seatImageUrl: state.mSeatBooking!.parkingImageUrl,
                      categoryName: state.mSeatBooking!.categoryName,
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state.building != null && state.floor != null)
                    _buildBuildingAndFloorWidget(
                      building: state.building,
                      floor: state.floor,
                    ),
                  if (state.mSeatBooking != null)
                    _buildBuildingAndFloorWidget(
                      building:
                          BuildingModel(name: state.mSeatBooking!.buildingName),
                      floor: FloorModel(name: state.mSeatBooking!.floorName),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateValueGreyTileWidget(
                          title: 'Date',
                          value: state.selectedDay,
                          onTap: () async {
                            if (state.isForRescheduling &&
                                state.mSeatBooking != null &&
                                state.mSeatBooking!.bookingDate != null) {
                              await showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return BookParkingRescheduleCalendarBottomSheet(
                                    defaultDate: DateFormat('yyyy-MM-dd').parse(
                                      state.mSeatBooking!.bookingDate!,
                                    ),
                                    parentContext: context,
                                  );
                                },
                                isScrollControlled: true,
                                // shape: const RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.only(
                                //     topLeft: Radius.circular(20),
                                //     topRight: Radius.circular(20),
                                //   ),
                                // ),
                              );
                            }
                          },
                          bookingDate: state.mSeatBooking?.bookingDate,
                        ),
                      ),
                      if (state.seatConfiguration != null)
                        Expanded(
                          child: _buildTitleValueGreyTileWidget(
                            title: 'Parking Category',
                            value: state.seatConfiguration!.parkingCategory ??
                                'Hot Desk',
                            onTap: () {},
                          ),
                        ),
                      if (state.mSeatBooking != null)
                        Expanded(
                          child: _buildTitleValueGreyTileWidget(
                            title: 'Parking Category',
                            value:
                                state.mSeatBooking!.categoryName ?? 'Hot Desk',
                            onTap: () async {
                              await showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext _) {
                                    return BookParkingCategoryBottomSheet(
                                      parentContext: context,
                                      buildingId: state.mSeatBooking!.buildingId
                                          .toString(),
                                      floorId: state.mSeatBooking!.floorId
                                          .toString(),
                                    );
                                  },
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ));
                            },
                          ),
                        ),
                    ],
                  ),
                  if (state.slotsList.isNotEmpty)
                    BookParkingSlotListWidget(slotsList: state.slotsList),
                  if (state.slotsList.isNotEmpty &&
                      state.seatDetailsList.isNotEmpty &&
                      !state.isWaitListEnabled)
                    BookParkingSlotSeatListWidget(
                      seatDetails: state.seatDetailsList,
                      floorAttachment: state.isForRescheduling
                          ? state.mSeatBooking?.floorPlanAttachment
                          : state.floor?.floorPlanAttachment,
                    ),
                  const BookParkingTermsWidget(),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (context
                .watch<BookParkingDateAndSlotProvider>()
                .isWaitListEnabled)
              InkWell(
                onTap: () {
                  Provider.of<BookParkingDateAndSlotProvider>(context,
                          listen: false)
                      .onBookSpaceClicked(parentContext: context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor(spaceManagementMainButtonColor),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Pending',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              InkWell(
                onTap: () {
                  Provider.of<BookParkingDateAndSlotProvider>(context,
                          listen: false)
                      .onBookSpaceClicked(parentContext: context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor(spaceManagementMainButtonColor),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.routeModel.isForRescheduling
                              ? 'RESCHEDULE'
                              : 'BOOK Parking Slot',
                          style: const TextStyle(
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

  Widget _buildHeaderImage({String? seatImageUrl, String? categoryName}) {
    String assetsImage = 'assets/space_management/seat_category_images/';
    String assetsName = 'default_cabin_big';
    switch (categoryName ?? '') {
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
    return Stack(
      children: [
        Image.asset('assets/space_management/ic_space_detail_background.png'),
        FractionalTranslation(
          translation: const Offset(0.0, 0.2),
          child: seatImageUrl != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    seatImageUrl,
                    fit: BoxFit.fill,
                    width: 100,
                    height: 100,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    '$assetsImage$assetsName.png',
                    fit: BoxFit.fill,
                    width: 100,
                    height: 100,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildBuildingAndFloorWidget({
    BuildingModel? building,
    FloorModel? floor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (building != null)
            BuildAndFloorTextTile(title: building.name ?? '', onTap: () {}),
          const SizedBox(
            width: 10,
          ),
          if (floor != null)
            BuildAndFloorTextTile(title: floor.name ?? '', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildTitleValueGreyTileWidget({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: HexColor(bookSpaceDateAndSlotsNewUiFieldbgColor)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateValueGreyTileWidget({
    required String title,
    DateTime? value,
    required VoidCallback onTap,
    String? bookingDate,
  }) {
    String tempDate = 'Tues, Jan 29, 2021';
    if (bookingDate != null) {
      DateFormat sdf1 = DateFormat("yyyy-MM-dd");
      try {
        DateTime dSelectedDate = sdf1.parse(bookingDate);
        tempDate = DateFormat("EEE, MMM dd, yyyy").format(dSelectedDate);
      } catch (e) {
        logError(msg: e);
      }
    } else {
      if (value != null) {
        tempDate = DateFormat("EEE, MMM dd, yyyy").format(value);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: HexColor(bookSpaceDateAndSlotsNewUiFieldbgColor)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tempDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
