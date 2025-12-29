import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/booking_parking_detail_screen/dialog/book_parking_booking_cancel_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/booking_parking_detail_screen/dialog/booking_parking_details_cancel_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/show_schedule/show_schedule.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';

class BookingParkingDetailProvider extends ChangeNotifier {
  IParkingManagementRepository parkingManagementRepository =
      ParkingManagementRepository();

  ParkingSeatBooking? seatBooking;

  bool isCancelPressed = false;

  void init({required BuildContext context, required String seatId}) {
    isCancelPressed = false;
    notifyListeners();
    getSeatBookingDetails(context: context, bookingId: seatId);
  }

  void onCancelSlotCheckBoxClicked({
    required ShowSchedule showSchedule,
    required bool value,
  }) {
    if (seatBooking == null) {
      return;
    }
    if (seatBooking!.showSchedule == null) {
      return;
    }
    seatBooking!.showSchedule!.isChecked = value;
    // for (var item in seatBooking!.showSchedule!) {
    //   if (item.id == showSchedule.id) {
    //     item.isChecked = value;
    //   }
    // }
    notifyListeners();
  }

  Future<void> onCheckInClick(
      {required BuildContext context,
      required int slotId,
      required String bookingId}) async {
    final response = await parkingManagementRepository.sendPunchInDetails(
        context: context, slotId: slotId);

    if (response) {
      showToastDialog(msg: 'Checked in successfully');
      getSeatBookingDetails(context: context, bookingId: bookingId);
    }
  }

  Future<void> onCheckOutClick({
    required BuildContext context,
    required String attendanceId,
    required String workLog,
    required String bookingId,
  }) async {
    final response = await parkingManagementRepository.sendPunchOutDetails(
        attendanceId: attendanceId, context: context, workLog: workLog);
    if (response) {
      showToastDialog(msg: 'Checked out successfully');
      Navigator.pop(context);
    }
  }

  Future<void> onCancelClicked({
    required BuildContext context,
    required ParkingSeatBooking booking,
  }) async {
    if (!isCancelPressed) {
      isCancelPressed = true;
      notifyListeners();
      return;
    }
    // List<int> tempSelectedSlots = [];
    if (booking.showSchedule == null) {
      showToastDialog(msg: 'Somthing went wrong, please try again later!');
      return;
    }
    // for (var item in booking.showSchedule!) {
    //   if (item.isChecked) {
    //     if (item.slotId != null) {
    //       tempSelectedSlots.add(item.slotId!);
    //     }
    //   }
    // }
    // if (tempSelectedSlots.isEmpty) {
    //   showToastDialog(msg: 'Please select slots for cancellation.');
    //   return;
    // }
    // PutCancelSlotSRequestParameters request = PutCancelSlotSRequestParameters();
    // request.slotIds = tempSelectedSlots;
    // if (tempSelectedSlots.length == booking.showSchedule!.length) {
    //   request.status = 'cancelled';
    // }

    await showDialog(
      context: context,
      builder: (_) {
        return BookingParkingDetailsCancelDialog(
          parentContext: context,
          cancelledById: Prefs.getUserId().toString(),
          bookingId: booking.id.toString(),
        );
      },
    );
  }

  Future<void> onCancelConfirmClicked({
    required BuildContext parentContext,
    required String bookingId,
    required String cancelledById,
  }) async {
    final response = await parkingManagementRepository.sendCancelRequest(
      context: parentContext,
      bookingId: bookingId,
      cancelledById: cancelledById,
      status: 'cancelled',
    );

    if (response) {
      // showToastDialog(msg: 'Booked Seat cancel successfully');
      await showDialog(
          context: parentContext,
          builder: (_) {
            return BookParkingBookingCancelDialog(
              parentContext: parentContext,
              bookingId: bookingId,
            );
          }).then((value) => Navigator.pop(parentContext));
      // Navigator.pop(parentContext);
    }
  }

  Future<void> getSeatBookingDetails(
      {required BuildContext context, required String bookingId}) async {
    final response = await parkingManagementRepository.getSeatBookingDetail(
        context: context, bookingId: bookingId);
    if (response != null) {
      seatBooking = response;
      notifyListeners();
    }
  }
}
