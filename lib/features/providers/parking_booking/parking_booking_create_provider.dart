import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_bookings_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_schedules/parking_booking_schedules_slot_model/parking_booking_schedules_slot_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_building_model/parking_booking_building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_floor_model/parking_booking_floor_model.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_categories_model/parking_categories_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_book_parking/parking_booking_book_parking_response_model/parking_booking_book_parking_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';



class ParkingBookingCreateProvider extends ChangeNotifier {
  ParkingBookingsRepository repository = ParkingBookingsRepository();

  // Date  
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  // Building & Floor
  List<ParkingBookingBuildingModel> buildings = [];
  List<ParkingBookingFloorModel> floors = [];

  String selectedBuildingName = '';
  ParkingBookingBuildingModel? selectedBuilding;
  String selectedFloorName = '';
  ParkingBookingFloorModel? selectedFloor;

  List<ParkingCategoriesModel> parkingCategories = [];
  // int? selectedParkingCategoryId;
  ParkingCategoriesModel? selectedParkingCategory;

  List<ParkingBookingSchedulesSlotModel> slots = [];
  List<ParkingBookingSchedulesSlotModel> selectedSlots = [];
  List<int> selectedSlotsId = [];
  int selectedSlotCount = 0;

  double minTimeRange = 0;
  double maxTimeRange = 0;

  SfRangeValues? currentRangeValues;
  double minTimeInternal = 0;
  double maxTimeInternal = 0;

  init({
    required String selectedDate,
  }) {
    clearData();
    // getBuildingsAndFloor(selectedDate: selectedDate);
    getCategories();
  }

  clearData() {
    buildings.clear();
    floors.clear();
    selectedFloor = null;
    parkingCategories.clear();
    selectedParkingCategory = null;
    slots.clear();
    selectedSlots.clear();
    selectedSlotsId.clear();
    selectedBuildingName = '';
    selectedFloorName = '';
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
    minTimeRange = 0;
    maxTimeRange = 0;
    minTimeInternal = 0;
    maxTimeInternal = 0;
    currentRangeValues = null;
    notifyListeners();
  }

  Future<void> onDateSelected({
    required BuildContext context,
    required DateTime selectDay,
    required DateTime focusDay,
  }) async {
    clearData();
    focusedDay = focusDay;
    selectedDay = selectDay;
    buildings.clear();

    if (Utils.dateIsBefore(date: selectDay)) {
      showToastDialog(msg: 'Cant book past dates');
      // isSelectedDateBefore = true;
    } else {
      // isSelectedDateBefore = false;
    }
    notifyListeners();
    getCategories();
    // await getBuildingsAndFloor(selectedDate: selectDay.toIso8601String());
  }

  void onCalendarDateSelected({
    required BuildContext context,
    required String facilityId,
    required DateTime selectedDay,
    required DateTime focusedDay,
  }) async {
    selectedDay = selectedDay;
    focusedDay = focusedDay;
    notifyListeners();
    // await getBuildingsAndFloor(selectedDate: selectedDay.toIso8601String());
    getCategories();
  }

  Future<void> getBuildingsAndFloor({
    required String selectedDate,
    String? categoryId,
  }) async {
    final response = await repository.getBuildings(
      currentDate: selectedDate,
      categoryId: categoryId,
    );

    if (response != null &&
        response.buildings != null &&
        response.buildings!.isNotEmpty) {
      buildings = response.buildings!;

      selectedBuildingName = buildings[0].name ?? "";
      selectedBuilding = buildings[0];
      notifyListeners();

      if (buildings[0].floors != null && buildings[0].floors!.isNotEmpty) {
        floors = buildings[0].floors!;

        selectedFloorName = floors[0].name ?? "NA";
        selectedFloor = floors[0];

        getSchedules(
            selectedParkingConfigId: '${selectedFloor?.configurationId}');
        notifyListeners();
      }
    }
  }

  Future<void> onBuildingChanged({
    required ParkingBookingBuildingModel value,
  }) async {
    selectedBuilding = value;
    floors = selectedBuilding?.floors ?? [];
    selectedFloorName = floors[0].name ?? "NA";
    selectedFloor = floors[0];
    // selectedFloor = null;
    notifyListeners();
  }

  Future<void> onFloorChanged({
    required ParkingBookingFloorModel value,
  }) async {
    if (value.availableParkings != null && value.availableParkings! > 0) {
      selectedFloor = value;
      notifyListeners();
      // parkingCategories.clear();
      // notifyListeners();
      // await getCategories(
      //     buildingId: '${selectedBuilding?.id}',
      //     floorId: '${selectedFloor?.id}');

      getSchedules(
          selectedParkingConfigId: '${selectedFloor?.configurationId}');
    } else {
      showToastDialog(msg: 'Parking not avalaible on selected floor!');
    }
  }

  // Future<void> getCategories(
  //     //   {
  //     //   required String buildingId,
  //     //   required String floorId,
  //     // }
  //     ) async {
  //   final response = await repository.getCategories(
  //       // buildingId: buildingId, floorId: floorId
  //       );

  //   if (response != null &&
  //       response.parkingConfiguration != null &&
  //       response.parkingConfiguration!.isNotEmpty) {
  //     parkingCategories = response.parkingConfiguration!;
  //     notifyListeners();
  //   }
  // }

  Future<void> getCategories(
      //   {
      //   required String buildingId,
      //   required String floorId,
      // }
      ) async {
    final response = await repository.getCategories(
        // buildingId: buildingId, floorId: floorId
        );

    parkingCategories = response ?? [];
    notifyListeners();
  }

  Future<void> onParkingCategoryChanged({
    required ParkingCategoriesModel value,
    required String selectedDate,
  }) async {
    selectedParkingCategory = value;
    slots.clear();
    selectedSlots.clear();
    selectedSlotsId.clear();
    buildings.clear();
    floors.clear();
    selectedFloor = null;
    selectedBuilding = null;
    notifyListeners();

    getBuildingsAndFloor(
        selectedDate: selectedDate,
        categoryId: selectedParkingCategory?.id?.toString());
  }

  Future<void> getSchedules({
    required String selectedParkingConfigId,
  }) async {
    final response = await repository.getSchedules(
      parkingConfigurationId: selectedParkingConfigId,
      currentDate: selectedDay.toIso8601String(),
      // currentDate: '2023-11-02T19:13:54.540223',
    );

    if (response != null &&
        response.slots != null &&
        response.slots!.isNotEmpty) {
      slots = response.slots!;
      notifyListeners();
    }
    if (slots.isNotEmpty) {
      if (slots.first.startHour != null) {
        minTimeInternal = slots.first.startHour!.toDouble();
      }
      if (slots.last.endHour != null) {
        maxTimeInternal = slots.last.endHour!.toDouble();
      }
      logInfo(
          msg:
              'minTimeInternal:$minTimeInternal : maxTimeInternal:$maxTimeInternal');
      if (minTimeInternal > 0 && maxTimeInternal > 0) {
        currentRangeValues = SfRangeValues(minTimeInternal, maxTimeInternal);
      }
      notifyListeners();
    }
  }

  void onTimeRangeChanged({
    required SfRangeValues value,
  }) {
    currentRangeValues = value;
    notifyListeners();
  }

  Future<void> onTimeSlotChanged(
      {required ParkingBookingSchedulesSlotModel value}) async {
    // final temp;
    for (var item in slots) {
      if (item.id == value.id) {
        item.isSelected = !item.isSelected;
      }
    }

    notifyListeners();
  }

  Future<bool> onProceedClicked() async {
    if (selectedParkingCategory?.id == null) {
      showToastDialog(msg: 'Please Select Parking Category');
      return false;
    }

    // // if (selectedSlots.isEmpty) {
    // //   showToastDialog(msg: 'Please Select Slot');
    // //   return false;
    // // }
    // selectedSlots.clear();
    // for (var item in slots) {
    //   if (item.isSelected == true) {
    //     selectedSlots.add(item);
    //     if (item.id != null) {
    //       selectedSlotsId.add(item.id!);
    //     }
    //     // return false;
    //   }
    // }
    if (currentRangeValues == null) {
      showToastDialog(msg: 'Please Select Slot');
      return false;
    }

    if (currentRangeValues?.start == currentRangeValues?.end) {
      showToastDialog(msg: 'Start & End Time cannot be same.');
      return false;
    }

    if ((selectedFloor?.availableParkings ?? 0) == 0) {
      showToastDialog(msg: 'Selected Floor has no parking available.');
      return false;
    }

    // minTimeRange = minTime;
    // maxTimeRange = maxTime;
    // notifyListeners();

    return true;
  }

  Future<ParkingBookingBookParkingResponseModel?> bookParking(
      {required BuildContext parentContext}) async {
    if (selectedParkingCategory?.id == null) {
      showToastDialog(msg: 'Please Select Parking Category');
      return null;
    }

    if (currentRangeValues == null) {
      showToastDialog(msg: 'Please Select Slot');
      return null;
    }

    final response = await repository.bookParking(
      bookingDate: selectedDay.toIso8601String(),
      parkingConfigurationId: '${selectedFloor?.configurationId}',
      selectedSlots: selectedSlotsId,
      minTime: currentRangeValues!.start,
      maxTime: currentRangeValues!.end,
      parentContext: parentContext,
    );

    if (response != null) {
      showToastDialog(msg: 'Parking Booked Successfully');

      return response;
    } else {
      // showToastDialog(msg: somethingWentWrong);
      return null;
    }
  }
}
