import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/fixed_booked_available_count_response/fixed_booked_available_count_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_response_model/floor_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/put_cancel_slots_request_parameters/put_cancel_slots_request_parameters.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/response_model/seat_booking_list_response_model/seat_booking_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_approval_request/seat_approval_request_response_model/seat_approval_request_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking.dart';

abstract class ISpaceManagementRepository {
  Future<SeatBookingListResponseModel?> getSeatBookingList(
      {BuildContext? context});

  Future<BuildingResponseModel?> getBuildingList({required String date});

  Future<FloorResponseModel?> getFloors({
    required String date,
    required String buildingId,
  });

  Future<FixedBookedAvailableCountResponseModel?>
      getSpaceManagementFixedBookedAvailableCountsList(
          {required String buildingId,
          required String floorId,
          required String date});

  Future<SeatApprovalRequestResponseModel?> getSeatApprovalRequestList();

  Future<bool> sendPunchInDetails({
    BuildContext? context,
    required int slotId,
    int? parkingBookingId,
  });
  Future<bool> sendPunchOutDetails({
    BuildContext? context,
    required String attendanceId,
    required String workLog,
    int? parkingBookingId,
  });

  Future<bool> sendCancelRequest({
    required BuildContext context,
    required String bookingId,
    required PutCancelSlotSRequestParameters request,
  });

  // Future<SeatConfigurationDetailResponseModel?> getSeatConfigurationResponse(
  //     {BuildContext? context,
  //     required String buildingId,
  //     required String floorId});

  Future<bool> sendApprovalRequest(
      {required BuildContext context,
      required String seatConfigurationId,
      required DateTime selectDate});

  // Future<ScheduleListResponseModel?> getSlots({
  //   required BuildContext context,
  //   required String seatConfigurationId,
  //   required DateTime selectedDate,
  // });

  // Future<SeatBooking?> postBookSeatRequest({
  //   required BuildContext context,
  //   required PostBookingRequestModel request,
  //   required bool isForRescheduling,
  //   required bool isWaitingListEnabled,
  //   String mSeatBookingId = '',
  // });

  Future<SeatBooking?> getSeatBookingDetail({
    required BuildContext context,
    required String bookingId,
  });
}
