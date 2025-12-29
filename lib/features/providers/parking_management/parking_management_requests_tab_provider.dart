import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_model/parking_seat_approval_request_model.dart';

class ParkingManagementRequestsTabProvider extends ChangeNotifier {
  IParkingManagementRepository parkingManagementRepository =
      ParkingManagementRepository();

  bool isLoading = true;
  String errorMsg = '';
  List<ParkingSeatApprovalRequestModel> seatApprovalRequests = [];

  void init({required BuildContext context}) {
    isLoading = true;
    errorMsg = '';
    notifyListeners();
    getSeatApprovalRequestList(context: context);
  }

  Future<void> getSeatApprovalRequestList(
      {required BuildContext context}) async {
    isLoading = true;
    errorMsg = '';
    seatApprovalRequests.clear();
    notifyListeners();

    final response =
        await parkingManagementRepository.getSeatApprovalRequestList();
    if (response != null) {
      if (response.parkingApprovalRequests != null) {
        isLoading = false;
        errorMsg = '';
        seatApprovalRequests.addAll(response.parkingApprovalRequests!);
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
