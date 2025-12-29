import 'package:flutter/material.dart';

import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
import '../../models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_management_repository.dart';

class ParkingListProvider extends ChangeNotifier {
  ParkingManagementRepository parkingManagementRepository =
      ParkingManagementRepository();

  bool isLoading = true;
  String errorMsg = '';
  List<ParkingSeatBooking> myBookings = [];
  List<ParkingSeatBooking> cancelledBookings = [];

  void init({required BuildContext context}) {
    isLoading = true;
    errorMsg = '';
    notifyListeners();
    getSeatBookingList(context: context);
  }

  // Future<bool> sendPunchInDetails(
  //     {required BuildContext context, required int slotId}) async {
  //   final response = await parkingManagementRepository.sendPunchInDetails(
  //       context: context, slotId: slotId);
  //   if (response) {
  //     showToastDialog(msg: 'Checked in successfully');
  //     getSeatBookingList(context: context);
  //   }
  //   return response;
  // }

  // Future<bool> sendPunchOutDetails(
  //     {required BuildContext context,
  //     required String attendanceId,
  //     required String workLog}) async {
  //   final response = await parkingManagementRepository.sendPunchOutDetails(
  //       context: context, attendanceId: attendanceId, workLog: workLog);
  //   if (response) {
  //     showToastDialog(msg: 'Checked out successfully');
  //     getSeatBookingList(context: context);
  //   }
  //   return response;
  // }

  Future<void> getSeatBookingList({required BuildContext context}) async {
    isLoading = true;
    errorMsg = '';
    myBookings.clear();
    notifyListeners();

    final response = await parkingManagementRepository.getSeatBookingList();
    if (response != null) {
      if (response.parkingBookings != null) {
        isLoading = false;
        errorMsg = '';
        myBookings.addAll(response.parkingBookings!);
        notifyListeners();
      } else {
        isLoading = false;
        errorMsg = 'No Data Available';
        notifyListeners();
      }
    } else {
      isLoading = false;
      errorMsg = 'No Data Available';
      notifyListeners();
    }
  }
}
