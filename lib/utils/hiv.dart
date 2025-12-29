
import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_fixed_booked_available_count_response_model/parking_fixed_booked_available_count_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_response_model/parking_seat_approval_request_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking_list_response_model/parking_seat_booking_list_response_model.dart';
import 'package:hive/hive.dart';

class Hiv {
  static late final Box<dynamic> box;
  static Future<Box<dynamic>> init() async => box = Hive.box('cache');

  static String buildingResponse = 'building_response';
  static String seatBookingListResponse = 'seat_booking_list_response';
  static String fixedBookedAvailableCountResponseModel =
      'fixed_booked_available_count_response_model';
  static String seatApprovalRequestResponseModel =
      'seat_approval_request_response_model';

  //Parking Management
  static String parkingFixedBookedAvailableCountResponseModel =
      'parking_fixed_booked_available_count_response_model';
  static String parkingSeatBookingListResponse =
      'parking_seat_booking_list_response';
  static String parkingSeatApprovalRequestResponseModel =
      'parking_seat_approval_request_response_model';

  static void setBuildingResponse(BuildingResponseModel response) {
    box.put(buildingResponse, response);
  }

  static BuildingResponseModel? getBuildingResponse() {
    return box.get(buildingResponse);
  }

  // static void setSeatBookingListResponse(
  //     SeatBookingListResponseModel response) {
  //   box.put(seatBookingListResponse, response);
  // }

  // static SeatBookingListResponseModel? getSeatBookingListResponse() {
  //   return box.get(seatBookingListResponse);
  // }

  // static void setFixedBookedAvailableCountResponseModel(
  //     FixedBookedAvailableCountResponseModel response) {
  //   box.put(fixedBookedAvailableCountResponseModel, response);
  // }

  // static FixedBookedAvailableCountResponseModel?
  //     getFixedBookedAvailableCountResponseModel() {
  //   return box.get(fixedBookedAvailableCountResponseModel);
  // }

  // static void setSeatApprovalRequestResponseModel(
  //     SeatApprovalRequestResponseModel response) {
  //   box.put(seatApprovalRequestResponseModel, response);
  // }

  // static SeatApprovalRequestResponseModel?
  //     getSeatApprovalRequestResponseModel() {
  //   return box.get(seatApprovalRequestResponseModel);
  // }

  static void setParkingFixedBookedAvailableCountResponseModel(response) {
    box.put(parkingFixedBookedAvailableCountResponseModel, response);
  }

  static ParkingFixedBookedAvailableCountResponseModel?
      getParkingFixedBookedAvailableCountResponseModel() {
    return box.get(parkingFixedBookedAvailableCountResponseModel);
  }

  static void setParkingSeatBookingListResponse(
      ParkingSeatBookingListResponseModel response) {
    box.put(parkingSeatBookingListResponse, response);
  }

  static ParkingSeatBookingListResponseModel?
      getParkingSeatBookingListResponse() {
    return box.get(parkingSeatBookingListResponse);
  }

  static void setParkingSeatApprovalRequestResponseModel(
      ParkingSeatApprovalRequestResponseModel response) {
    box.put(parkingSeatApprovalRequestResponseModel, response);
  }

  static ParkingSeatApprovalRequestResponseModel?
      getParkingSeatApprovalRequestResponseModel() {
    return box.get(parkingSeatApprovalRequestResponseModel);
  }

  static Future<int> clear() async {
    return await box.clear();
  }
}
