import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_management_repository.dart';
//import 'package:flutter_pkg_lockated_book_parking/features/models/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floor_model/floor_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_schedule_list_response_model/parking_schedule_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_slot_model/parking_slot_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_number_model/parking_number_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/show_schedule/show_schedule.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_model/parking_seat_configuration_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/dialog/book_parking_confirm_booking_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/book_parking_date_and_slot_screen/dialog/book_parking_than_you_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart'; 
import 'package:flutter_pkg_lockated_book_parking/widgets/common/book_space_than_you_dialog.dart';
class BookParkingDateAndSlotProvider extends ChangeNotifier {
  IParkingManagementRepository parkingManagementRepository =
      ParkingManagementRepository() as IParkingManagementRepository;

  ParkingSeatConfigurationDetailModel? seatConfiguration;
  DateTime? selectedDay;
  BuildingModel? building;
  FloorModel? floor;
  bool isForRescheduling = false;
  ParkingSeatBooking? mSeatBooking;

  bool isWaitListEnabled = false;

  bool isTermsChecked = false;

  ParkingScheduleListResponseModel? scheduleListResponseModel;
  List<ParkingSlotModel> slotsList = [];
  List<ParkingNumberModel> seatDetailsList = [];
  String _searchString = '';
  List<ParkingNumberModel> get filteredSeatDetailsList => _searchString.isEmpty
      ? seatDetailsList
      : seatDetailsList
          .where((item) =>
              item.name != null &&
              item.name!.toLowerCase().contains(_searchString.toLowerCase()))
          .toList();

  void init({
    required BuildContext context,
    ParkingSeatConfigurationDetailModel? seatConfigurationModel,
    DateTime? selectDay,
    BuildingModel? buildingModel,
    FloorModel? floorModel,
    required bool isForRescheduling,
    ParkingSeatBooking? seatBooking,
  }) {
    clearData();
    seatConfiguration = seatConfigurationModel;
    selectedDay = selectDay;
    building = buildingModel;
    floor = floorModel;
    try {
      logInfo(msg: floor?.floorPlanAttachment ?? 'else');
    } catch (e) {}
    this.isForRescheduling = isForRescheduling;
    mSeatBooking = seatBooking;

    notifyListeners();
    if (!isForRescheduling) {
      if (selectDay != null && seatConfigurationModel != null) {
        getSlots(
          context: context,
          seatConfigurationId: seatConfigurationModel.id.toString(),
          selectedDate: selectDay,
        );
      }
    } else {
      if (mSeatBooking != null) {
        getSlots(
          context: context,
          seatConfigurationId: mSeatBooking!.parkingConfigurationId.toString(),
          selectedDate:
              DateFormat("yyyy-MM-dd").parse(mSeatBooking!.bookingDate!),
        );
      }
    }
  }

  void clearData() {
    isTermsChecked = false;
    slotsList.clear();
    seatDetailsList.clear();
    // filteredSeatDetailsList.clear();
    _searchString = '';
    notifyListeners();
  }

  void onSlotChanged({required ParkingSlotModel slot}) {
    for (var item in slotsList) {
      if (item.id == slot.id) {
        item.isSelected = !item.isSelected;
      } else {
        item.isSelected = false;
      }
    }

    ParkingSlotModel? tempSlot;
    for (var item in slotsList) {
      if (item.isSelected) {
        tempSlot = item;
      }
    }
    if (tempSlot != null) {
      seatDetailsList.clear();
      seatDetailsList.addAll(tempSlot.parkingNumbers ?? []);
      notifyListeners();
    } else {
      seatDetailsList.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  void onSlotSeatSelected({required ParkingNumberModel seat}) {
    for (var item in seatDetailsList) {
      if (item.id == seat.id) {
        item.isSelected = !item.isSelected;
      } else {
        item.isSelected = false;
      }
    }
    // for (var item in filteredSeatDetailsList) {
    //   if (item.id == seat.id) {
    //     item.isSelected = !item.isSelected;
    //   } else {
    //     item.isSelected = false;
    //   }
    // }
    notifyListeners();
  }

  void onSearched({required String input}) {
    // filteredSeatDetailsList.clear();
    // for (var item in seatDetailsList) {
    //   if (item.name?.toLowerCase() == input.toLowerCase()) {
    //     filteredSeatDetailsList.add(item);
    //   }
    // }
    _searchString = input;
    notifyListeners();
  }

  void onTermsCheckedChanged(bool value) {
    isTermsChecked = value;
    notifyListeners();
  }

  Future<void> onBookSpaceClicked({required BuildContext parentContext}) async {
    ParkingSlotModel? selectedSlot;
    ParkingNumberModel? selectedSeatDetails;
    for (var item in slotsList) {
      if (item.isSelected) {
        selectedSlot = item;
      }
    }
    for (var item in seatDetailsList) {
      if (item.isSelected) {
        selectedSeatDetails = item;
      }
    }
    if (selectedSlot == null) {
      showToastDialog(msg: 'Please select a slot.');
      return;
    }
    if (selectedSeatDetails == null && !isWaitListEnabled) {
      showToastDialog(msg: 'Please select a parking for all selected slots.');
      return;
    }
    if (selectedDay == null) {
      showToastDialog(msg: 'Please select a Date');
      return;
    }
    if (!isTermsChecked) {
      showToastDialog(msg: 'Please agree to terms and conditions.');
      return;
    }
    if (!isForRescheduling) {
      if (seatConfiguration == null) {
        showToastDialog(msg: 'Please Select a Seat Configuration.');
        return;
      }
    }

    // PostBookingRequestModel request = PostBookingRequestModel();

    // PostBookingSeatBookingModel seat_booking = PostBookingSeatBookingModel();
    // DateFormat sdf = DateFormat("dd/MM/yyyy");
    // String sBookingDate = sdf.format(selectedDay!);
    // seat_booking.bookingDate = sBookingDate;
    // seat_booking.seatConfigurationId = isForRescheduling
    //     ? mSeatBooking!.seatConfigurationId
    //     : seatConfiguration!.id;

    // List<ParkingSlotModel> selectedSlotForRequest = [];
    // for (var item in slotsList) {
    //   if (item.isSelected) {
    //     SelectedSlotModel tempSelectedParkingSlotModel = SelectedParkingSlotModel();
    //     tempSelectedParkingSlotModel.slotId = item.id;
    //     if (item.seatDetails != null && !isWaitListEnabled) {
    //       for (var seat in item.seatDetails!) {
    //         if (seat.isSelected) {
    //           tempSelectedParkingSlotModel.seatId = seat.id;
    //         }
    //       }
    //     }
    //     selectedSlotForRequest.add(tempSelectedParkingSlotModel);
    //   }
    // }
    // if (isForRescheduling) {
    //   seat_booking.status = 'rescheduled';
    //   for (var item in selectedSlotForRequest) {
    //     item.status = 'rescheduled';
    //   }
    // } else if (isWaitListEnabled) {
    //   seat_booking.status = 'waiting';
    //   for (var item in selectedSlotForRequest) {
    //     item.status = 'waiting';
    //     item.seatId = null;
    //   }
    // } else {
    //   seat_booking.status = 'confirmed';
    //   for (var item in selectedSlotForRequest) {
    //     item.status = 'confirmed';
    //   }
    // }

    // request.seatBooking = seat_booking;
    // request.selectedSlots = selectedSlotForRequest;

    DateFormat sdf = DateFormat("dd/MM/yyyy");
    String sBookingDate = sdf.format(selectedDay!);
    int? tempSeatConfigurationId = isForRescheduling
        ? mSeatBooking!.parkingConfigurationId
        : seatConfiguration!.id;
    // Open Confirm Dialog

    await showDialog(
      context: parentContext,
      builder: (context) {
        return BookParkingConfirmBookingDialog(
          // request: request,
          categoryName: isForRescheduling
              ? (mSeatBooking!.categoryName ?? '')
              : (seatConfiguration!.parkingCategory ?? ''),
          selectedParkingSlotModel: selectedSlot!,
          selectParkingNumberModel: selectedSeatDetails,
          parentContext: parentContext,
          isForRescheduling: isForRescheduling,
          bookingDate: sBookingDate,
          parkingConfigurationId: tempSeatConfigurationId.toString(),
          parkingNumberId: selectedSeatDetails!.id.toString(),
          parkingTimeSlotId: selectedSlot.id.toString(),
        );
      },
    );
  }

  void handleDateSelectionFromFragment(BuildContext parentContext,
      DateTime date, BuildingModel building, FloorModel floor) {
    isDateChanged = true;

    ParkingSeatBooking tempSeatBooking = ParkingSeatBooking();
    selectedDay = date;

    DateFormat sdf1 = DateFormat("yyyy-MM-dd");
    if (mSeatBooking != null) {
      mSeatBooking!.bookingDate = sdf1.format(date);
      mSeatBooking!.floorId = floor.id;
      mSeatBooking!.floorName = floor.name;
      mSeatBooking!.buildingId = building.id;
      mSeatBooking!.buildingName = building.name;

      init(
        context: parentContext,
        isForRescheduling: true,
        seatBooking: mSeatBooking,
        selectDay: date,
      );
    } else {
      tempSeatBooking.bookingDate = sdf1.format(date);
      tempSeatBooking.floorId = floor.id;
      tempSeatBooking.floorName = floor.name;
      tempSeatBooking.buildingId = building.id;
      tempSeatBooking.buildingName = building.name;

      init(
          context: parentContext,
          isForRescheduling: true,
          seatBooking: tempSeatBooking);
    }
  }

  Future<void> postSeatBookingRequest({
    required BuildContext context,
    bool isForRescheduling = false,
    required String bookingDate,
    required String parkingConfigurationId,
    required String parkingTimeSlotId,
    required String parkingNumberId,
    String? parkingBookingId = '',
  }) async {
    final response = await parkingManagementRepository.postBookSeatRequest(
      context: context,
      isForRescheduling: isForRescheduling,
      isWaitingListEnabled: isWaitListEnabled,
      parkingBookingId: isForRescheduling ? mSeatBooking!.id.toString() : '',
      bookingDate: bookingDate,
      parkingConfigurationId: parkingConfigurationId,
      parkingTimeSlotId: parkingTimeSlotId,
      parkingNumberId: parkingNumberId,
    );

    logInfo(msg: 'response: $response');
    if (response != null) {
      logInfo(msg: 'Show Dialog');
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return BookSpaceThanYouDialog(
            parentContext: context,
            bookingId: response.id.toString(),
            isFromParking: true,
          );
        },
      );
    }
  }

  Future<void> getSlots({
    required BuildContext context,
    required String seatConfigurationId,
    required DateTime selectedDate,
  }) async {
    final response = await parkingManagementRepository.getSlots(
      context: context,
      seatConfigurationId: seatConfigurationId,
      selectedDate: selectedDate,
    );
    if (response != null) {
      setNormalAndWaitListingSlots(response: response);
      setTimeSlotsRecyclerView(true, response);
    }
  }

  void setNormalAndWaitListingSlots(
      {required ParkingScheduleListResponseModel response}) {
    scheduleListResponseModel = response;
    List<ParkingSlotModel> slots = scheduleListResponseModel!.slots ?? [];
    bool isWaitListingEnabled = checkIfAllSeatsOfAllSlotsAreBooked(slots);
    isWaitListEnabled = isWaitListingEnabled;
    notifyListeners();
    //TODO Uncomment This
    if (isWaitListingEnabled) {
      List<ParkingSlotModel> booked_slots =
          scheduleListResponseModel!.bookedSlots ?? [];
      for (int i = 0; i < booked_slots.length; i++) {
        ParkingSlotModel slot = booked_slots[i];
        List<ParkingNumberModel> booked_seat_details =
            slot.parkingNumbers ?? [];
        booked_slots[i].parkingNumbers = booked_seat_details;
      }

      scheduleListResponseModel!.slots = booked_slots;
    } else {
      List<ParkingSlotModel> lSlotToBeExcluded = [];
      for (int i = 0; i < slots.length; i++) {
        ParkingSlotModel slot = slots[i];
        bool isAllSeatsInSlotEmptyTemp = isAllSeatsInSlotEmpty(slot);
        if (isAllSeatsInSlotEmptyTemp) {
          lSlotToBeExcluded.add(slot);
        }
      }
      for (int i = 0; i < lSlotToBeExcluded.length; i++) {
        ParkingSlotModel slot = lSlotToBeExcluded[i];
        slots.remove(slot);
      }
      scheduleListResponseModel!.slots = slots;
    }
    slotsList = scheduleListResponseModel!.slots ?? [];
    notifyListeners();
  }

  void setTimeSlotsRecyclerView(
      bool isNotRescheduled, ParkingScheduleListResponseModel response) {
    List<ParkingSlotModel> slots = response.slots ?? [];

    if (isNotRescheduled) {
      if (isForRescheduling) {
        ParkingSeatConfigurationModel? seatConfiguration =
            response.parkingConfiguration;
        if (seatConfiguration == null) {
          return;
        }
        if (mSeatBooking == null) {
          return;
        }
        if (seatConfiguration.id == null) {
          return;
        }
        if (mSeatBooking!.parkingConfigurationId == null) {
          return;
        }

//            String sSeatCategory=seatConfiguration.getSeatCategory();

        int seatConfigurationId = seatConfiguration.id!;
        int selectedBookingSeatConfigurationId =
            mSeatBooking!.parkingConfigurationId!;

        if (seatConfigurationId == selectedBookingSeatConfigurationId) {
          List<ShowSchedule> showSchedule = mSeatBooking!.showSchedule != null
              ? [mSeatBooking!.showSchedule!]
              : [];
          for (int i = 0; i < showSchedule.length; i++) {
            ShowSchedule schedule = showSchedule[i];
            int selectedBookingSlotId = schedule.id!;
            for (int j = 0; j < slots.length; j++) {
              ParkingSlotModel slot = slots[j];

              int currentSlotId = slot.id!;

              if (currentSlotId == selectedBookingSlotId) {
                if (!isDateChanged) {
                  logInfo(msg: 'isDateChanged: false');
                  scheduleListResponseModel!.slots![j].isSelectedBeforeBooking =
                      true;
                } else {
                  logInfo(msg: 'isDateChanged: false');
                  scheduleListResponseModel!.slots![j].isSelectedBeforeBooking =
                      false;
                }
                break;
              } else {
                scheduleListResponseModel!.slots![j].isSelectedBeforeBooking =
                    false;
              }
            }
          }
        }
      }
    } else {
      for (int i = 0; i < scheduleListResponseModel!.slots!.length; i++) {
        scheduleListResponseModel!.slots![i].isSelectedBeforeBooking = false;
      }
    }
    slotsList = scheduleListResponseModel!.slots ?? [];
    notifyListeners();
  }

  bool isAllSeatsInSlotEmpty(ParkingSlotModel slot) {
    List<ParkingNumberModel> seatDetails = slot.parkingNumbers ?? [];
    if (seatDetails.isEmpty) {
      return true;
    }

    return false;
  }

  bool checkIfAllSeatsOfAllSlotsAreBooked(List<ParkingSlotModel> slots) {
    for (int i = 0; i < slots.length; i++) {
      ParkingSlotModel slot = slots[i];
      if (!isAllSeatsInSlotEmpty(slot)) {
        return false;
      }
    }
    return true;
  }

  //Function For Rescheduling
  List<ParkingSeatConfigurationDetailModel>
      categoryBottomSheetSeatConfigurations = [];
  bool isCategoryBottomSheetSeatConfigurationLoading = true;
  String categoryBottomSheetSeatConfigurationErrorMsg = '';

  bool isDateChanged = false;

  void initCategoryBottomSheet({
    required BuildContext context,
    required String buildingId,
    required String floorId,
  }) {
    categoryBottomSheetSeatConfigurations.clear();
    categoryBottomSheetSeatConfigurationErrorMsg = '';
    notifyListeners();
    getSeatConfigurationsList(
        context: context, buildingId: buildingId, floorId: floorId);
  }

  void getSelectedConfiguration({
    required ParkingSeatConfigurationDetailModel seatConfigurationDetailModel,
    required BuildContext parentContext,
  }) {
    if (mSeatBooking != null && mSeatBooking!.bookingDate != null) {
      mSeatBooking!.categoryName = seatConfigurationDetailModel.parkingCategory;
      mSeatBooking!.parkingConfigurationId = seatConfigurationDetailModel.id;
      slotsList.clear();
      seatDetailsList.clear();
      getSlots(
        context: parentContext,
        seatConfigurationId: mSeatBooking!.parkingConfigurationId.toString(),
        selectedDate:
            DateFormat("yyyy-MM-dd").parse(mSeatBooking!.bookingDate!),
      );
    }
  }

  Future<void> getSeatConfigurationsList({
    required BuildContext context,
    required String buildingId,
    required String floorId,
  }) async {
    isCategoryBottomSheetSeatConfigurationLoading = true;
    categoryBottomSheetSeatConfigurationErrorMsg = '';
    categoryBottomSheetSeatConfigurations.clear();
    notifyListeners();

    final response =
        await parkingManagementRepository.getSeatConfigurationResponse(
            context: context, buildingId: buildingId, floorId: floorId);
    if (response != null && response.seatConfigurations != null) {
      categoryBottomSheetSeatConfigurations = response.seatConfigurations!;
      isCategoryBottomSheetSeatConfigurationLoading = false;
      categoryBottomSheetSeatConfigurationErrorMsg = '';
      notifyListeners();
    } else {
      isCategoryBottomSheetSeatConfigurationLoading = false;
      categoryBottomSheetSeatConfigurationErrorMsg = 'No Data Available';
      notifyListeners();
    }
  }
}
