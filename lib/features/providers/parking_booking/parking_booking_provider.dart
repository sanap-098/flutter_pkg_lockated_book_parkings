import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_space_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_bookings_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_bookings_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/space_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import '../../models/parking_booking/parking_bookings/parking_bookings_model/parking_bookings_model.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
class ParkingBookingProvider extends ChangeNotifier {
  IParkingBookingsRepository repository = ParkingBookingsRepository() as IParkingBookingsRepository;
  ISpaceManagementRepository spaceManagementRepository =
      SpaceManagementRepository();

  bool isLoading = true;
  String errorMsg = '';
  List<ParkingBookingsModel> myBookings = [];
  List<ParkingBookingsModel> cancelledBookings = [];

  void init({required BuildContext context}) {
    getParkingBookingList(context: context);
  }

  clearData() {
    isLoading = true;
    errorMsg = '';
    myBookings.clear();
    cancelledBookings.clear();
    notifyListeners();
  }

  Future<bool?> cancelParkingBooking(
      {required String parkingId, required BuildContext parentContext}) async {
    final response = await repository.cancelParking(
        id: parkingId, parentContext: parentContext);

    if (response != null) {
      showToastDialog(msg: 'Parking Cancelled Successfully');
      return true;
    } else {
      showToastDialog(msg: somethingWentWrong);
      return false;
    }
  }

  Future<bool> sendPunchInDetails({
    required BuildContext context,
    int? parkingBookingId,
  }) async {
    final response = await spaceManagementRepository.sendPunchInDetails(
      context: context,
      slotId: 0,
      parkingBookingId: parkingBookingId,
    );
    if (response && context.mounted) {
      showToastDialog(msg: 'Checked in successfully');
      getParkingBookingList(context: context);
    }
    return response;
  }

  Future<bool> sendPunchOutDetails({
    required BuildContext context,
    required String attendanceId,
    required String workLog,
    int? parkingBookingId,
  }) async {
    final response = await spaceManagementRepository.sendPunchOutDetails(
      context: context,
      attendanceId: attendanceId,
      workLog: workLog,
      parkingBookingId: parkingBookingId,
    );
    if (response && context.mounted) {
      showToastDialog(msg: 'Checked out successfully');
      getParkingBookingList(context: context);
    }
    return response;
  }

  Future<void> getParkingBookingList({required BuildContext context}) async {
    isLoading = true;
    errorMsg = '';
    myBookings.clear();
    notifyListeners();

    final response = await repository.getParkingList();
    if (response != null) {
      if (response.parkingBookings != null &&
          response.parkingBookings!.isNotEmpty) {
        isLoading = false;
        errorMsg = '';

        List<ParkingBookingsModel> tempCancelledBookings = [];
        List<ParkingBookingsModel> tempMyBookings = [];

        for (var element in response.parkingBookings!) {
          if (element.status != null &&
              element.status!.isNotEmpty &&
              (element.status!.toLowerCase() == 'cancelled' ||
                  element.status!.toLowerCase() == 'expired')) {
            // cancelledBookings.add(element);
            tempCancelledBookings.add(element);
          } else {
            // myBookings.add(element);
            tempMyBookings.add(element);
          }
        }

        cancelledBookings = tempCancelledBookings;
        myBookings = tempMyBookings;

        logInfo(msg: "Cancelled Bookings Length: ${cancelledBookings.length}");
        logInfo(msg: "Normal Bookings Length: ${myBookings.length}");
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
