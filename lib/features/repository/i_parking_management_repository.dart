import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_response_model/floor_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_fixed_booked_available_count_response_model/parking_fixed_booked_available_count_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_schedule_list_response_model/parking_schedule_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_response_model/parking_seat_approval_request_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking_list_response_model/parking_seat_booking_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_response_model/parking_seat_configuration_detail_response_model.dart';
//import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/response_model.dart';
abstract class IParkingManagementRepository {
  Future<ParkingSeatBookingListResponseModel?> getSeatBookingList(
      {BuildContext? context});

  Future<BuildingResponseModel?> getBuildingList({required String date});

  Future<FloorResponseModel?> getFloors({
    required String date,
    required String buildingId,
  });

  Future<ParkingFixedBookedAvailableCountResponseModel?>
      getParkingManagementFixedBookedAvailableCountsList(
          {required String buildingId,
          required String floorId,
          required String date});

  Future<ParkingSeatApprovalRequestResponseModel?> getSeatApprovalRequestList();

  Future<bool> sendPunchInDetails({BuildContext? context, required int slotId});
  Future<bool> sendPunchOutDetails({
    BuildContext? context,
    required String attendanceId,
    required String workLog,
  });

  Future<bool> sendCancelRequest({
    required BuildContext context,
    required String bookingId,
    required String status,
    required String cancelledById,
  });

  Future<ParkingSeatConfigurationDetailResponseModel?>
      getSeatConfigurationResponse(
          {BuildContext? context,
          required String buildingId,
          required String floorId});

  Future<bool> sendApprovalRequest(
      {required BuildContext context,
      required String parkingConfigurationId,
      required DateTime selectDate});

  Future<ParkingScheduleListResponseModel?> getSlots({
    required BuildContext context,
    required String seatConfigurationId,
    required DateTime selectedDate,
  });

  Future<ParkingSeatBooking?> postBookSeatRequest({
    required BuildContext context,
    required bool isForRescheduling,
    required bool isWaitingListEnabled,
    required String bookingDate,
    required String parkingConfigurationId,
    required String parkingTimeSlotId,
    required String parkingNumberId,
    String? parkingBookingId = '',
  });

  Future<ParkingSeatBooking?> getSeatBookingDetail({
    required BuildContext context,
    required String bookingId,
  });

  Future<ResponseModel?> getParkingAutoCheckInOut({
    required String lockatedToken,
    required bool checkIn,
  });
}
