import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floor_model/floor_model.dart'; 
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_response_model/floor_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_fixed_booked_available_count_response_model/parking_fixed_booked_available_count_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_model/parking_seat_approval_request_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_response_model/parking_seat_approval_request_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking_list_response_model/parking_seat_booking_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_model/parking_seat_configuration_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/book_parking_date_and_slot_route_model.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/loading_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/dialog/parking_management_send_request_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_configuration_detail_model/seat_configuration_detail_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';

class ParkingManagementFragmentProvider extends ChangeNotifier {
  final IParkingManagementRepository parkingManagementRepository =
      ParkingManagementRepository();

  ParkingSeatBookingListResponseModel? seatBookingListResponseModel;
  BuildingResponseModel? buildingResponseModel;
  FloorResponseModel? floorResponseModel;
  ParkingFixedBookedAvailableCountResponseModel?
      fixedBookedAvailableCountResponseModel;
  ParkingSeatApprovalRequestResponseModel? seatApprovalRequestResponseModel;

  ParkingSeatApprovalRequestModel? seatApprovalRequestModel;

  List<ParkingSeatBooking> seatBookings = [];
  List<ParkingSeatBooking> selectedDateBookedSeats = [];
  List<String> blueDates = [];

  List<BuildingModel> buildings = [];
  List<FloorModel> floors = [];

  List<ParkingSeatConfigurationModel> seatConfigurations = [];

  String buildingName = '';
  String floorName = '';
  int buildingId = 0;
  int floorId = 0;

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  bool showCalendar = false;
  bool showApprovalRequestView = false;
  bool isSelectedDateBefore = false;
  bool showRequestButton = false;
  bool showNextButton = false;

  //Roaster Logic
  int bookedDaysPerWeek = 0;
  int totalBookingDaysPerWeek = 0;
  String roasterType = '';

  //Send Request
  SeatConfigurationDetailModel? sendRequestCategoryName;

  Future<void> init(
      {required BuildContext context, DateTime? selectDate}) async {
    clearData();
    showCalendar = true;
    notifyListeners();
    if (selectDate != null) {
      selectedDay = selectDate;
      notifyListeners();
    }
    if (Prefs.getTowerName() != null) {
      buildingName = Prefs.getTowerName() ?? '';
    }
    if (Prefs.getFloorName() != null) {
      floorName = Prefs.getFloorName() ?? '';
    }
    if (Prefs.getTowerId() != null) {
      buildingId = Prefs.getTowerId()!;
    }
    if (Prefs.getFloorId() != null) {
      floorId = Prefs.getFloorId()!;
    }
    await getSeatBookings(context: context);
    await getBuildingsList(
        context: context, selectedDate: selectDate ?? DateTime.now());
    if (buildingId != 0 && floorId != 0) {
      await getSeatApprovalRequestList(context: context);
      await getFixedBookedAvailableCount(
        context: context,
        date: selectDate ?? DateTime.now(),
        buildingId: buildingId,
        floorId: floorId,
      );
    }
  }

  void clearData() {
    selectedDay = DateTime.now();
    showCalendar = false;
    seatBookingListResponseModel = null;
    seatBookings.clear();
    selectedDateBookedSeats.clear();
    blueDates.clear();
    buildingResponseModel = null;
    buildings.clear();
    floorResponseModel = null;
    floors.clear();
    fixedBookedAvailableCountResponseModel = null;
    seatConfigurations.clear();
    seatApprovalRequestResponseModel = null;
    seatApprovalRequestModel = null;
    showApprovalRequestView = false;
    isSelectedDateBefore = false;
    showRequestButton = false;

    bookedDaysPerWeek = 0;
    totalBookingDaysPerWeek = 0;
    roasterType = '';

    sendRequestCategoryName = null;

    notifyListeners();
  }

  void updateCountUI() {
    bool isBookingsPresent = bookingsPresentInCurrentlySelectedDate();
    bool isSelectedDateBeforeToday = Utils.dateIsBefore(date: selectedDay);
    bool isToday = Utils.isToday(date: selectedDay);

    bool canBookSeat = false;
    if (fixedBookedAvailableCountResponseModel != null &&
        fixedBookedAvailableCountResponseModel!.canBookSeat != null) {
      canBookSeat =
          fixedBookedAvailableCountResponseModel!.canBookSeat ?? false;
    }

    if (!isBookingsPresent) {
      if (canBookSeat) {
        showNextButton = true;
        notifyListeners();
      } else {
        showNextButton = false;
        notifyListeners();
      }
      showRequestButton = false;

      notifyListeners();
      bool showApprovalBtn = false;

      if (fixedBookedAvailableCountResponseModel != null &&
          fixedBookedAvailableCountResponseModel!.showApprovalBtn != null) {
        showApprovalBtn =
            fixedBookedAvailableCountResponseModel!.showApprovalBtn ?? false;
      }

      if ((!isSelectedDateBeforeToday) || isToday) {
        if ((null != showApprovalBtn) && (showApprovalBtn)) {
          showRequestButton = true;
          notifyListeners();
        } else {
          showApprovalRequestView = false;
          notifyListeners();
        }
      } else {
        showApprovalRequestView = false;
        notifyListeners();
      }
    } else {
      showApprovalRequestView = false;
      showRequestButton = false;
      showNextButton = false;
      notifyListeners();
    }
    showApprovalRequestView = false;
    notifyListeners();
    if (seatApprovalRequestResponseModel != null) {
      if (seatApprovalRequestResponseModel!.parkingApprovalRequests != null &&
          seatApprovalRequestResponseModel!
              .parkingApprovalRequests!.isNotEmpty) {
        for (var item
            in seatApprovalRequestResponseModel!.parkingApprovalRequests!) {
          if (item.date != null) {
            if (Utils.matchDate(
                date1: DateFormat("yyyy-MM-dd").parse(item.date!),
                date2: selectedDay)) {
              showApprovalRequestView = true;
              seatApprovalRequestModel = item;
              notifyListeners();
              break;
            }
          }
        }
      }
    }
    logError(msg: 'showNext Button: $showNextButton');
  }

  Future<void> dateSelected(
      {required BuildContext context,
      required DateTime selectDay,
      required DateTime focusDay}) async {
    focusedDay = focusDay;
    selectedDay = selectDay;
    selectedDateBookedSeats.clear();
    if (Utils.dateIsBefore(date: selectDay)) {
      showNextButton = false;
      showToastDialog(msg: 'Cant book past dates');
      isSelectedDateBefore = true;
    } else {
      isSelectedDateBefore = false;
    }
    notifyListeners();
    if (seatBookings.isNotEmpty) {
      setSeatBookings(selectedDate: selectDay, seatBookings: seatBookings);
    }
    await getBuildingsList(context: context, selectedDate: selectDay);
    if (buildingId != 0 && floorId != 0) {
      await getFixedBookedAvailableCount(
        context: context,
        date: selectDay,
        buildingId: buildingId,
        floorId: floorId,
      );
      if (seatApprovalRequestResponseModel == null) {
        await getSeatApprovalRequestList(context: context);
      } else {
        updateCountUI();
      }
    }
  }

  void setSeatBookings(
      {required DateTime selectedDate,
      required List<ParkingSeatBooking> seatBookings}) {
    String formatedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    selectedDateBookedSeats.clear();
    for (var item in seatBookings) {
      if (item.bookingDate == formatedDate) {
        if (item.status != null &&
            !(item.status!.trim().toLowerCase() == 'cancelled')) {
          selectedDateBookedSeats.add(item);
        }
      }
    }
    notifyListeners();
    if (seatBookings.isNotEmpty) {
      showNextButton = false;
      notifyListeners();
    }
  }

  Future<void> buildingSelected(
      {required BuildContext context, required BuildingModel building}) async {
    if (building.id != null && building.name != null) {
      buildingId = building.id!;
      buildingName = building.name!;
      fixedBookedAvailableCountResponseModel = null;
      seatConfigurations.clear();
      notifyListeners();
      await getFloorsList(
          context: context, buildingId: buildingId, selectedDate: selectedDay);
    } else {
      showToastDialog(msg: 'Select a Different Tower!');
    }
  }

  Future<void> floorSelected(
      {required BuildContext context, required FloorModel floor}) async {
    if (floor.id != null && floor.name != null) {
      floorId = floor.id!;
      floorName = floor.name!;
      notifyListeners();
      if (buildingId != 0 && floorId != 0) {
        await getFixedBookedAvailableCount(
          context: context,
          date: selectedDay,
          buildingId: buildingId,
          floorId: floorId,
        );
        if (seatApprovalRequestResponseModel == null) {
          await getSeatApprovalRequestList(context: context);
        } else {
          updateCountUI();
        }
      }
    }
  }

  Future<void> openBookSeatScreen({
    required BuildContext context,
    required ParkingSeatConfigurationModel seatConfiguration,
  }) async {
    if (showRequestButton == false) {
      BuildingModel? building;
      FloorModel? floor;
      if (buildings.isNotEmpty) {
        for (var item in buildings) {
          if (item.id == buildingId) {
            building = item;
          }
        }
        if (building == null) {
          building = BuildingModel(id: buildingId, name: buildingName);
        }
      } else {
        building = BuildingModel(id: buildingId, name: buildingName);
      }

      if (floors.isNotEmpty) {
        for (var item in floors) {
          if (item.id == floorId) {
            floor = item;
          }
        }
        if (floor == null) {
          floor = FloorModel(id: floorId, name: floorName);
        }
      } else {
        floor = FloorModel(id: floorId, name: floorName);
      }

      final res =
          await parkingManagementRepository.getSeatConfigurationResponse(
        context: context,
        buildingId: building.id.toString(),
        floorId: floor.id.toString(),
      );

      if (res != null &&
          res.seatConfigurations != null &&
          res.seatConfigurations!.isNotEmpty) {
        for (var item in res.seatConfigurations!) {
          if (item.id != null &&
              seatConfiguration.id != null &&
              item.id == seatConfiguration.id) {
            
            // --- FIX: Using String Literal for Route Name ---
            // Ensure 'book_parking_date_and_slot' is defined in your MaterialApp routes
            Navigator.of(context).pushNamed(
                'book_parking_date_and_slot', 
                arguments: BookParkingDateAndSlotRouteModel(
                  seatConfiguration: item,
                  selectDay: selectedDay,
                  building: building,
                  floor: floor as dynamic,
                  isForRescheduling: false,
                ));
          }
        }
      }
    }
  }

  //Called Send Request Button Clicked on SpaceManagementScreen
  Future<void> sendRequestOpenPopupDialog({
    required BuildContext context,
  }) async {
    BuildingModel? building;
    FloorModel? floor;
    if (buildings.isNotEmpty) {
      for (var item in buildings) {
        if (item.id == buildingId) {
          building = item;
        }
      }
      if (building == null) {
        building = BuildingModel(id: buildingId, name: buildingName);
      }
    } else {
      building = BuildingModel(id: buildingId, name: buildingName);
    }

    if (floors.isNotEmpty) {
      for (var item in floors) {
        if (item.id == floorId) {
          floor = item;
        }
      }
      if (floor == null) {
        floor = FloorModel(id: floorId, name: floorName);
      }
    } else {
      floor = FloorModel(id: floorId, name: floorName);
    }

    final res = await parkingManagementRepository.getSeatConfigurationResponse(
      context: context,
      buildingId: building.id.toString(),
      floorId: floor.id.toString(),
    );
    if (res != null &&
        res.seatConfigurations != null &&
        res.seatConfigurations!.isNotEmpty) {
      List<ParkingSeatConfigurationDetailModel> seatCategory = [];
      for (var item in res.seatConfigurations!) {
        // if (item.seatCategory != null) {
        seatCategory.add(item as ParkingSeatConfigurationDetailModel);
        // }
      }
      //open dialog for request
      sendRequestCategoryName = null;
      String tempDate = DateFormat('dd/MM/yyyy').format(selectedDay);
      await showDialog(
        context: context,
        builder: (_) {
          return ParkingManagementSendRequestDialog(
            seatCategoryNames: seatCategory,
            date: tempDate,
            parentContext: context,
          );
        },
      );
    }
  }

  //Called when Ok Button Clicked on SpaceManegementSendRequestDialog
  Future<void> sendApprovalRequest(
      {required BuildContext context,
      required BuildContext parentContext}) async {
    if (sendRequestCategoryName == null) {
      showToastDialog(msg: 'Please select a Category Name!');
      return;
    }
    final response = await parkingManagementRepository.sendApprovalRequest(
      context: context,
      parkingConfigurationId: sendRequestCategoryName!.id.toString(),
      selectDate: selectedDay,
    );
    if (response) {
      Navigator.pop(context);
      init(context: parentContext, selectDate: selectedDay);
    }
  }

  bool bookingsPresentInCurrentlySelectedDate() {
    String sDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    List<ParkingSeatBooking> lSeatBooking = seatBookings;

    for (int i = 0; i < lSeatBooking.length; i++) {
      ParkingSeatBooking booking = lSeatBooking[i];
      String sBookingDate = booking.bookingDate ?? '';
      String sBookingStatus = booking.status ?? '';
      if (sBookingDate.trim().toLowerCase() == sDate.trim().toLowerCase()) {
        if (!(sBookingStatus.trim().toLowerCase() == "cancelled")) {
          return true;
        }
      }
    }
    return false;
  }

  void sendRequestCategoryNameChanged(
      {required SeatConfigurationDetailModel category}) {
    sendRequestCategoryName = category;
    notifyListeners();
  }

  Future<bool> getSeatBookings({required BuildContext context}) async {
    seatBookingListResponseModel = null;
    seatBookings.clear();
    notifyListeners();
    final response =
        await parkingManagementRepository.getSeatBookingList(context: context);
    if (response != null) {
      if (response.parkingBookings != null &&
          response.parkingBookings!.isNotEmpty) {
        seatBookingListResponseModel = response;
        seatBookings = response.parkingBookings!;
        for (var item in response.parkingBookings!) {
          if (item.status != null && item.status != 'cancelled') {
            if (item.bookingDate != null) {
              blueDates.add(item.bookingDate!);
            }
          }
        }
        setSeatBookings(
            selectedDate: selectedDay, seatBookings: response.parkingBookings!);
        showCalendar = true;
        notifyListeners();
      }
      return true;
    } else {
      showCalendar = true;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getBuildingsList({
    required BuildContext context,
    required DateTime selectedDate,
  }) async {
    buildingResponseModel = null;
    buildings.clear();
    floorResponseModel = null;
    floors.clear();
    notifyListeners();
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    String date = DateFormat('dd/MM/yyyy').format(selectedDate);
    try {
      final response =
          await parkingManagementRepository.getBuildingList(date: date);
      if (response != null) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        buildingResponseModel = response;
        buildings = response.buildings ?? [];
        notifyListeners();
        return true;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        return false;
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: e);
      return false;
    }
  }

  Future<bool> getFloorsList({
    required BuildContext context,
    required int buildingId,
    required DateTime selectedDate,
  }) async {
    floorResponseModel = null;
    floors.clear();
    floorId = 0;
    floorName = 'Select Floor';
    notifyListeners();
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    String date = DateFormat('dd/MM/yyyy').format(selectedDate);
    try {
      final response = await parkingManagementRepository.getFloors(
          date: date, buildingId: buildingId.toString());
      if (response != null) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        floorResponseModel = response;
        floors = response.floors ?? [];
        notifyListeners();
        return true;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        return false;
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: e);
      return false;
    }
  }

  Future<bool> getFixedBookedAvailableCount({
    required BuildContext context,
    required DateTime date,
    required int buildingId,
    required int floorId,
  }) async {
    fixedBookedAvailableCountResponseModel = null;
    seatConfigurations.clear();
    notifyListeners();
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    String tempDate = DateFormat('dd/MM/yyyy').format(date);
    try {
      final response = await parkingManagementRepository
          .getParkingManagementFixedBookedAvailableCountsList(
              date: tempDate,
              buildingId: buildingId.toString(),
              floorId: floorId.toString());
      if (response != null) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        fixedBookedAvailableCountResponseModel = response;
        seatConfigurations = response.parkingConfigurations ?? [];
        bookedDaysPerWeek = response.bookedDaysPerWeek ?? 0;
        totalBookingDaysPerWeek = response.totalDaysPerWeek ?? 0;
        roasterType = response.roasterType ?? '';
        updateCountUI();
        notifyListeners();
        return true;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        return false;
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: e);
      return false;
    }
  }

  Future<bool> getSeatApprovalRequestList({
    required BuildContext context,
  }) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final response =
          await parkingManagementRepository.getSeatApprovalRequestList();
      if (response != null) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        seatApprovalRequestResponseModel = response;
        notifyListeners();
        if (response.parkingApprovalRequests != null &&
            response.parkingApprovalRequests!.isNotEmpty) {
          for (var item in response.parkingApprovalRequests!) {
            if (item.date != null) {
              if (Utils.matchDate(
                  date1: DateFormat("yyyy-MM-dd").parse(item.date!),
                  date2: selectedDay)) {
                showApprovalRequestView = true;
                seatApprovalRequestModel = item;
                notifyListeners();
                break;
              }
            }
          }
        }
        return true;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        return false;
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: e);
      return false;
    }
  }

  Future<bool> sendPunchInDetails(
      {required BuildContext context, required int slotId}) async {
    final response = await parkingManagementRepository.sendPunchInDetails(
        context: context, slotId: slotId);
    if (response) {
      showToastDialog(msg: 'Checked in successfully');
      getSeatBookings(context: context);
    }
    return response;
  }

  Future<bool> sendPunchOutDetails(
      {required BuildContext context,
      required String attendanceId,
      required String workLog}) async {
    final response = await parkingManagementRepository.sendPunchOutDetails(
        context: context, attendanceId: attendanceId, workLog: workLog);
    if (response) {
      showToastDialog(msg: 'Checked out successfully');
      getSeatBookings(context: context);
    }
    return response;
  }
}






// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:ndialog/ndialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_management_repository.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/floor_model/floor_model.dart'; 
// import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_response_model/floor_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_fixed_booked_available_count_response_model/parking_fixed_booked_available_count_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_model/parking_seat_approval_request_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_response_model/parking_seat_approval_request_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking_list_response_model/parking_seat_booking_list_response_model.dart';
// //import 'package:flutter_pkg_lockated_book_parking/features/models/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_model/parking_seat_configuration_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/book_parking_date_and_slot_route_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/loading_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/dialog/parking_management_send_request_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/seat_configuration_detail_model/seat_configuration_detail_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
// class ParkingManagementFragmentProvider extends ChangeNotifier {
//   final IParkingManagementRepository parkingManagementRepository =
//       ParkingManagementRepository();

//   ParkingSeatBookingListResponseModel? seatBookingListResponseModel;
//   BuildingResponseModel? buildingResponseModel;
//   FloorResponseModel? floorResponseModel;
//   ParkingFixedBookedAvailableCountResponseModel?
//       fixedBookedAvailableCountResponseModel;
//   ParkingSeatApprovalRequestResponseModel? seatApprovalRequestResponseModel;

//   ParkingSeatApprovalRequestModel? seatApprovalRequestModel;

//   List<ParkingSeatBooking> seatBookings = [];
//   List<ParkingSeatBooking> selectedDateBookedSeats = [];
//   List<String> blueDates = [];

//   List<BuildingModel> buildings = [];
//   List<FloorModel> floors = [];

//   List<ParkingSeatConfigurationModel> seatConfigurations = [];

//   String buildingName = '';
//   String floorName = '';
//   int buildingId = 0;
//   int floorId = 0;

//   DateTime focusedDay = DateTime.now();
//   DateTime selectedDay = DateTime.now();

//   bool showCalendar = false;
//   bool showApprovalRequestView = false;
//   bool isSelectedDateBefore = false;
//   bool showRequestButton = false;
//   bool showNextButton = false;

//   //Roaster Logic
//   int bookedDaysPerWeek = 0;
//   int totalBookingDaysPerWeek = 0;
//   String roasterType = '';

//   //Send Request
//   SeatConfigurationDetailModel? sendRequestCategoryName;

//   Future<void> init(
//       {required BuildContext context, DateTime? selectDate}) async {
//     clearData();
//     showCalendar = true;
//     notifyListeners();
//     if (selectDate != null) {
//       selectedDay = selectDate;
//       notifyListeners();
//     }
//     if (Prefs.getTowerName() != null) {
//       buildingName = Prefs.getTowerName() ?? '';
//     }
//     if (Prefs.getFloorName() != null) {
//       floorName = Prefs.getFloorName() ?? '';
//     }
//     if (Prefs.getTowerId() != null) {
//       buildingId = Prefs.getTowerId()!;
//     }
//     if (Prefs.getFloorId() != null) {
//       floorId = Prefs.getFloorId()!;
//     }
//     await getSeatBookings(context: context);
//     await getBuildingsList(
//         context: context, selectedDate: selectDate ?? DateTime.now());
//     if (buildingId != 0 && floorId != 0) {
//       await getSeatApprovalRequestList(context: context);
//       await getFixedBookedAvailableCount(
//         context: context,
//         date: selectDate ?? DateTime.now(),
//         buildingId: buildingId,
//         floorId: floorId,
//       );
//     }
//   }

//   void clearData() {
//     selectedDay = DateTime.now();
//     showCalendar = false;
//     seatBookingListResponseModel = null;
//     seatBookings.clear();
//     selectedDateBookedSeats.clear();
//     blueDates.clear();
//     buildingResponseModel = null;
//     buildings.clear();
//     floorResponseModel = null;
//     floors.clear();
//     fixedBookedAvailableCountResponseModel = null;
//     seatConfigurations.clear();
//     seatApprovalRequestResponseModel = null;
//     seatApprovalRequestModel = null;
//     showApprovalRequestView = false;
//     isSelectedDateBefore = false;
//     showRequestButton = false;

//     bookedDaysPerWeek = 0;
//     totalBookingDaysPerWeek = 0;
//     roasterType = '';

//     sendRequestCategoryName = null;

//     notifyListeners();
//   }

//   void updateCountUI() {
//     bool isBookingsPresent = bookingsPresentInCurrentlySelectedDate();
//     bool isSelectedDateBeforeToday = Utils.dateIsBefore(date: selectedDay);
//     bool isToday = Utils.isToday(date: selectedDay);

//     bool canBookSeat = false;
//     if (fixedBookedAvailableCountResponseModel != null &&
//         fixedBookedAvailableCountResponseModel!.canBookSeat != null) {
//       canBookSeat =
//           fixedBookedAvailableCountResponseModel!.canBookSeat ?? false;
//     }

//     if (!isBookingsPresent) {
//       if (canBookSeat) {
//         showNextButton = true;
//         notifyListeners();
//       } else {
//         showNextButton = false;
//         notifyListeners();
//       }
//       showRequestButton = false;

//       notifyListeners();
//       bool showApprovalBtn = false;

//       if (fixedBookedAvailableCountResponseModel != null &&
//           fixedBookedAvailableCountResponseModel!.showApprovalBtn != null) {
//         showApprovalBtn =
//             fixedBookedAvailableCountResponseModel!.showApprovalBtn ?? false;
//       }

//       if ((!isSelectedDateBeforeToday) || isToday) {
//         if ((null != showApprovalBtn) && (showApprovalBtn)) {
//           showRequestButton = true;
//           notifyListeners();
//         } else {
//           showApprovalRequestView = false;
//           notifyListeners();
//         }
//       } else {
//         showApprovalRequestView = false;
//         notifyListeners();
//       }
//     } else {
//       showApprovalRequestView = false;
//       showRequestButton = false;
//       showNextButton = false;
//       notifyListeners();
//     }
//     showApprovalRequestView = false;
//     notifyListeners();
//     if (seatApprovalRequestResponseModel != null) {
//       if (seatApprovalRequestResponseModel!.parkingApprovalRequests != null &&
//           seatApprovalRequestResponseModel!
//               .parkingApprovalRequests!.isNotEmpty) {
//         for (var item
//             in seatApprovalRequestResponseModel!.parkingApprovalRequests!) {
//           if (item.date != null) {
//             if (Utils.matchDate(
//                 date1: DateFormat("yyyy-MM-dd").parse(item.date!),
//                 date2: selectedDay)) {
//               showApprovalRequestView = true;
//               seatApprovalRequestModel = item;
//               notifyListeners();
//               break;
//             }
//           }
//         }
//       }
//     }
//     logError(msg: 'showNext Button: $showNextButton');
//   }

//   Future<void> dateSelected(
//       {required BuildContext context,
//       required DateTime selectDay,
//       required DateTime focusDay}) async {
//     focusedDay = focusDay;
//     selectedDay = selectDay;
//     selectedDateBookedSeats.clear();
//     if (Utils.dateIsBefore(date: selectDay)) {
//       showNextButton = false;
//       showToastDialog(msg: 'Cant book past dates');
//       isSelectedDateBefore = true;
//     } else {
//       isSelectedDateBefore = false;
//     }
//     notifyListeners();
//     if (seatBookings.isNotEmpty) {
//       setSeatBookings(selectedDate: selectDay, seatBookings: seatBookings);
//     }
//     await getBuildingsList(context: context, selectedDate: selectDay);
//     if (buildingId != 0 && floorId != 0) {
//       await getFixedBookedAvailableCount(
//         context: context,
//         date: selectDay,
//         buildingId: buildingId,
//         floorId: floorId,
//       );
//       if (seatApprovalRequestResponseModel == null) {
//         await getSeatApprovalRequestList(context: context);
//       } else {
//         updateCountUI();
//       }
//     }
//   }

//   void setSeatBookings(
//       {required DateTime selectedDate,
//       required List<ParkingSeatBooking> seatBookings}) {
//     String formatedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//     selectedDateBookedSeats.clear();
//     for (var item in seatBookings) {
//       if (item.bookingDate == formatedDate) {
//         if (item.status != null &&
//             !(item.status!.trim().toLowerCase() == 'cancelled')) {
//           selectedDateBookedSeats.add(item);
//         }
//       }
//     }
//     notifyListeners();
//     if (seatBookings.isNotEmpty) {
//       showNextButton = false;
//       notifyListeners();
//     }
//   }

//   Future<void> buildingSelected(
//       {required BuildContext context, required BuildingModel building}) async {
//     if (building.id != null && building.name != null) {
//       buildingId = building.id!;
//       buildingName = building.name!;
//       fixedBookedAvailableCountResponseModel = null;
//       seatConfigurations.clear();
//       notifyListeners();
//       await getFloorsList(
//           context: context, buildingId: buildingId, selectedDate: selectedDay);
//     } else {
//       showToastDialog(msg: 'Select a Different Tower!');
//     }
//   }

//   Future<void> floorSelected(
//       {required BuildContext context, required FloorModel floor}) async {
//     if (floor.id != null && floor.name != null) {
//       floorId = floor.id!;
//       floorName = floor.name!;
//       notifyListeners();
//       if (buildingId != 0 && floorId != 0) {
//         await getFixedBookedAvailableCount(
//           context: context,
//           date: selectedDay,
//           buildingId: buildingId,
//           floorId: floorId,
//         );
//         if (seatApprovalRequestResponseModel == null) {
//           await getSeatApprovalRequestList(context: context);
//         } else {
//           updateCountUI();
//         }
//       }
//     }
//   }

//   Future<void> openBookSeatScreen({
//     required BuildContext context,
//     required ParkingSeatConfigurationModel seatConfiguration,
//   }) async {
//     if (showRequestButton == false) {
//       BuildingModel? building;
//       FloorModel? floor;
//       if (buildings.isNotEmpty) {
//         for (var item in buildings) {
//           if (item.id == buildingId) {
//             building = item;
//           }
//         }
//         if (building == null) {
//           building = BuildingModel(id: buildingId, name: buildingName);
//         }
//       } else {
//         building = BuildingModel(id: buildingId, name: buildingName);
//       }

//       if (floors.isNotEmpty) {
//         for (var item in floors) {
//           if (item.id == floorId) {
//             floor = item;
//           }
//         }
//         if (floor == null) {
//           floor = FloorModel(id: floorId, name: floorName);
//         }
//       } else {
//         floor = FloorModel(id: floorId, name: floorName);
//       }

//       final res =
//           await parkingManagementRepository.getSeatConfigurationResponse(
//         context: context,
//         buildingId: building.id.toString(),
//         floorId: floor.id.toString(),
//       );

//       if (res != null &&
//           res.seatConfigurations != null &&
//           res.seatConfigurations!.isNotEmpty) {
//         for (var item in res.seatConfigurations!) {
//           if (item.id != null &&
//               seatConfiguration.id != null &&
//               item.id == seatConfiguration.id) {
//             //Open Book Seat Screen

//             Navigator.of(context).pushNamed(Routes.bookParkingDateAndSlot,
//                 arguments: BookParkingDateAndSlotRouteModel(
//                   seatConfiguration: item,
//                   selectDay: selectedDay,
//                   building: building,
//                   floor: floor as dynamic,
//                   isForRescheduling: false,
//                 ));
//           }
//         }
//       }
//     }
//   }

//   //Called Send Request Button Clicked on SpaceManagementScreen
//   Future<void> sendRequestOpenPopupDialog({
//     required BuildContext context,
//   }) async {
//     BuildingModel? building;
//     FloorModel? floor;
//     if (buildings.isNotEmpty) {
//       for (var item in buildings) {
//         if (item.id == buildingId) {
//           building = item;
//         }
//       }
//       if (building == null) {
//         building = BuildingModel(id: buildingId, name: buildingName);
//       }
//     } else {
//       building = BuildingModel(id: buildingId, name: buildingName);
//     }

//     if (floors.isNotEmpty) {
//       for (var item in floors) {
//         if (item.id == floorId) {
//           floor = item;
//         }
//       }
//       if (floor == null) {
//         floor = FloorModel(id: floorId, name: floorName);
//       }
//     } else {
//       floor = FloorModel(id: floorId, name: floorName);
//     }

//     final res = await parkingManagementRepository.getSeatConfigurationResponse(
//       context: context,
//       buildingId: building.id.toString(),
//       floorId: floor.id.toString(),
//     );
//     if (res != null &&
//         res.seatConfigurations != null &&
//         res.seatConfigurations!.isNotEmpty) {
//       List<ParkingSeatConfigurationDetailModel> seatCategory = [];
//       for (var item in res.seatConfigurations!) {
//         // if (item.seatCategory != null) {
//         seatCategory.add(item as ParkingSeatConfigurationDetailModel);
//         // }
//       }
//       //open dialog for request
//       sendRequestCategoryName = null;
//       String tempDate = DateFormat('dd/MM/yyyy').format(selectedDay);
//       await showDialog(
//         context: context,
//         builder: (_) {
//           return ParkingManagementSendRequestDialog(
//             seatCategoryNames: seatCategory,
//             date: tempDate,
//             parentContext: context,
//           );
//         },
//       );
//     }
//   }

//   //Called when Ok Button Clicked on SpaceManegementSendRequestDialog
//   Future<void> sendApprovalRequest(
//       {required BuildContext context,
//       required BuildContext parentContext}) async {
//     if (sendRequestCategoryName == null) {
//       showToastDialog(msg: 'Please select a Category Name!');
//       return;
//     }
//     final response = await parkingManagementRepository.sendApprovalRequest(
//       context: context,
//       parkingConfigurationId: sendRequestCategoryName!.id.toString(),
//       selectDate: selectedDay,
//     );
//     if (response) {
//       Navigator.pop(context);
//       init(context: parentContext, selectDate: selectedDay);
//     }
//   }

//   bool bookingsPresentInCurrentlySelectedDate() {
//     String sDate = DateFormat('yyyy-MM-dd').format(selectedDay);
//     List<ParkingSeatBooking> lSeatBooking = seatBookings;

//     for (int i = 0; i < lSeatBooking.length; i++) {
//       ParkingSeatBooking booking = lSeatBooking[i];
//       String sBookingDate = booking.bookingDate ?? '';
//       String sBookingStatus = booking.status ?? '';
//       if (sBookingDate.trim().toLowerCase() == sDate.trim().toLowerCase()) {
//         if (!(sBookingStatus.trim().toLowerCase() == "cancelled")) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }

//   void sendRequestCategoryNameChanged(
//       {required SeatConfigurationDetailModel category}) {
//     sendRequestCategoryName = category;
//     notifyListeners();
//   }

//   Future<bool> getSeatBookings({required BuildContext context}) async {
//     seatBookingListResponseModel = null;
//     seatBookings.clear();
//     notifyListeners();
//     final response =
//         await parkingManagementRepository.getSeatBookingList(context: context);
//     if (response != null) {
//       if (response.parkingBookings != null &&
//           response.parkingBookings!.isNotEmpty) {
//         seatBookingListResponseModel = response;
//         seatBookings = response.parkingBookings!;
//         for (var item in response.parkingBookings!) {
//           if (item.status != null && item.status != 'cancelled') {
//             if (item.bookingDate != null) {
//               blueDates.add(item.bookingDate!);
//             }
//           }
//         }
//         setSeatBookings(
//             selectedDate: selectedDay, seatBookings: response.parkingBookings!);
//         showCalendar = true;
//         notifyListeners();
//       }
//       return true;
//     } else {
//       showCalendar = true;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> getBuildingsList({
//     required BuildContext context,
//     required DateTime selectedDate,
//   }) async {
//     buildingResponseModel = null;
//     buildings.clear();
//     floorResponseModel = null;
//     floors.clear();
//     notifyListeners();
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     String date = DateFormat('dd/MM/yyyy').format(selectedDate);
//     try {
//       final response =
//           await parkingManagementRepository.getBuildingList(date: date);
//       if (response != null) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         buildingResponseModel = response;
//         buildings = response.buildings ?? [];
//         notifyListeners();
//         return true;
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         return false;
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: e);
//       return false;
//     }
//   }

//   Future<bool> getFloorsList({
//     required BuildContext context,
//     required int buildingId,
//     required DateTime selectedDate,
//   }) async {
//     floorResponseModel = null;
//     floors.clear();
//     floorId = 0;
//     floorName = 'Select Floor';
//     notifyListeners();
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     String date = DateFormat('dd/MM/yyyy').format(selectedDate);
//     try {
//       final response = await parkingManagementRepository.getFloors(
//           date: date, buildingId: buildingId.toString());
//       if (response != null) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         floorResponseModel = response;
//         floors = response.floors ?? [];
//         notifyListeners();
//         return true;
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         return false;
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: e);
//       return false;
//     }
//   }

//   Future<bool> getFixedBookedAvailableCount({
//     required BuildContext context,
//     required DateTime date,
//     required int buildingId,
//     required int floorId,
//   }) async {
//     fixedBookedAvailableCountResponseModel = null;
//     seatConfigurations.clear();
//     notifyListeners();
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     String tempDate = DateFormat('dd/MM/yyyy').format(date);
//     try {
//       final response = await parkingManagementRepository
//           .getParkingManagementFixedBookedAvailableCountsList(
//               date: tempDate,
//               buildingId: buildingId.toString(),
//               floorId: floorId.toString());
//       if (response != null) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         fixedBookedAvailableCountResponseModel = response;
//         seatConfigurations = response.parkingConfigurations ?? [];
//         bookedDaysPerWeek = response.bookedDaysPerWeek ?? 0;
//         totalBookingDaysPerWeek = response.totalDaysPerWeek ?? 0;
//         roasterType = response.roasterType ?? '';
//         updateCountUI();
//         notifyListeners();
//         return true;
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         return false;
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: e);
//       return false;
//     }
//   }

//   Future<bool> getSeatApprovalRequestList({
//     required BuildContext context,
//   }) async {
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     try {
//       final response =
//           await parkingManagementRepository.getSeatApprovalRequestList();
//       if (response != null) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         seatApprovalRequestResponseModel = response;
//         notifyListeners();
//         if (response.parkingApprovalRequests != null &&
//             response.parkingApprovalRequests!.isNotEmpty) {
//           for (var item in response.parkingApprovalRequests!) {
//             if (item.date != null) {
//               if (Utils.matchDate(
//                   date1: DateFormat("yyyy-MM-dd").parse(item.date!),
//                   date2: selectedDay)) {
//                 showApprovalRequestView = true;
//                 seatApprovalRequestModel = item;
//                 notifyListeners();
//                 break;
//               }
//             }
//           }
//         }
//         return true;
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         return false;
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: e);
//       return false;
//     }
//   }

//   Future<bool> sendPunchInDetails(
//       {required BuildContext context, required int slotId}) async {
//     final response = await parkingManagementRepository.sendPunchInDetails(
//         context: context, slotId: slotId);
//     if (response) {
//       showToastDialog(msg: 'Checked in successfully');
//       getSeatBookings(context: context);
//     }
//     return response;
//   }

//   Future<bool> sendPunchOutDetails(
//       {required BuildContext context,
//       required String attendanceId,
//       required String workLog}) async {
//     final response = await parkingManagementRepository.sendPunchOutDetails(
//         context: context, attendanceId: attendanceId, workLog: workLog);
//     if (response) {
//       showToastDialog(msg: 'Checked out successfully');
//       getSeatBookings(context: context);
//     }
//     return response;
//   }
// }
