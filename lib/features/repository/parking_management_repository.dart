import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/book_parking_end_points.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:flutter_pkg_resident_urbanwork_widgets/core/constants/core_http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_response_model/floor_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_fixed_booked_available_count_response_model/parking_fixed_booked_available_count_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_schedule_list_response_model/parking_schedule_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_response_model/parking_seat_approval_request_response_model.dart';

// --- FIX: UPDATED IMPORT TO MATCH INTERFACE ---
// Old (Wrong): import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_seat_booking/parking_seat_booking.dart'; 
// ----------------------------------------------

import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking_list_response_model/parking_seat_booking_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_response_model/parking_seat_configuration_detail_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/loading_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart'; // Ensure Util is imported

class ParkingManagementRepository extends IParkingManagementRepository {
  @override
  Future<ParkingSeatBookingListResponseModel?> getSeatBookingList(
      {BuildContext? context}) async {
    CustomProgressDialog? pd;
    if (context != null) {
      pd = loadingPleaseWaitDialog(context: context);
      pd.show();
    }
    try {
      // final prefs = await SharedPreferences.getInstance();
      String? token = Prefs.getLockatedToken();
      if (token == null || token.isEmpty) {
        token = Prefs.getLockatedSSOToken();
      }
      final url = '${BookParkingEndPoints.getParkingSeatBookingListNew}$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg: 'getSeatBookingList\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = ParkingSeatBookingListResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        return null;
      }
    } catch (e) {
      if (pd != null && pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: 'Api getSeatBookingList Error: $e');
      return null;
    }
  }

  @override
  Future<BuildingResponseModel?> getBuildingList({required String date}) async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getParkingManagementBuildingsList}$date&token=$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(msg: 'getBuildings\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res =
            BuildingResponseModel.fromJson(result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getBuildings Error: $e');
      return null;
    }
  }

  @override
  Future<FloorResponseModel?> getFloors(
      {required String date, required String buildingId}) async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getParkingManagementFloorList}$buildingId&date=$date&token=$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(msg: 'getFloors\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = FloorResponseModel.fromJson(result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getFloors Error: $e');
      return null;
    }
  }

  @override
  Future<ParkingFixedBookedAvailableCountResponseModel?>
      getParkingManagementFixedBookedAvailableCountsList({
    required String buildingId,
    required String floorId,
    required String date,
  }) async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getParkingManagementFixedBookedAvailableCountsList}building_id=$buildingId&floor_id=$floorId&date=$date&token=$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getParkingManagementFixedBookedAvailableCountsList\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = ParkingFixedBookedAvailableCountResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(
          msg:
              'Api getParkingManagementFixedBookedAvailableCountsList Error: $e');
      return null;
    }
  }

  @override
  Future<ParkingSeatApprovalRequestResponseModel?>
      getSeatApprovalRequestList() async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url = '${BookParkingEndPoints.getParkingSeatApprovalRequests}$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getSeatApprovalRequestList\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = ParkingSeatApprovalRequestResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getSeatApprovalRequestList Error: $e');
      return null;
    }
  }

  @override
  Future<bool> sendPunchInDetails(
      {BuildContext? context, required int slotId}) async {
    CustomProgressDialog? pd;
    if (context != null) {
      pd = loadingPleaseWaitDialog(context: context);
    }
    if (pd != null) {
      pd.show();
    }
    try {
      // final prefs = await SharedPreferences.getInstance();
      String? token = Prefs.getLockatedToken();
      if (token == null || token.isEmpty) {
        token = Prefs.getLockatedSSOToken();
      }

      Map<String, String> header = {
        "Content-Type": "application/json;charset=UTF-8",
        'Authorization': token ?? '',
      };
      Map<String, dynamic> body = {
        "image": null,
        "seat_booking_slot_id": slotId,
      };

      final response = await http.post(
          Uri.parse(BookParkingEndPoints.sendParkingPunchInDetals),
          body: jsonEncode(body),
          headers: header);
      logInfo(
          msg:
              'sendPunchInDetails \nurl: ${BookParkingEndPoints.sendParkingPunchInDetals}\nheader: $header\nbody: $body\nresponse: ${response.body}');

      if (response.statusCode == 200) {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      } else {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      if (pd != null && pd.isShowed) {
        pd.dismiss();
      }

      Util.showToast('Something went wrong, please try again later!');
      logError(msg: e.toString());
      return false;
    }
  }

  @override
  Future<bool> sendPunchOutDetails(
      {BuildContext? context,
      required String attendanceId,
      required String workLog}) async {
    CustomProgressDialog? pd;
    if (context != null) {
      pd = loadingPleaseWaitDialog(context: context);
    }
    if (pd != null) {
      pd.show();
    }
    try {
      // final prefs = await SharedPreferences.getInstance();
      String? token = Prefs.getLockatedToken();
      if (token == null || token.isEmpty) {
        token = Prefs.getLockatedSSOToken();
      }

      Map<String, String> header = {
        'Authorization': token ?? '',
      };
      Map<String, dynamic> body = {
        "work_log": workLog,
      };

      final response = await http.post(
          Uri.parse(
              '${BookParkingEndPoints.sendParkingPunchOutDetals}$attendanceId/punch_out.json?'),
          body: jsonEncode(body),
          headers: header);
      logInfo(msg: body.toString() + " result " + response.body.toString());

      if (response.statusCode == 200) {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      } else {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      if (pd != null && pd.isShowed) {
        pd.dismiss();
      }

      Util.showToast('Something went wrong, please try again later!');
      logError(msg: e.toString());
      return false;
    }
  }

  @override
  Future<bool> sendCancelRequest({
    required BuildContext context,
    required String bookingId,
    required String status,
    required String cancelledById,
  }) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final token = Prefs.getLockatedToken();

      Map<String, String> header = {
        'Authorization': token ?? '',
        'Content-Type': 'application/json;charset=UTF-8',
      };

      final body = {
        "parking_booking": {
          "status": status,
          "cancelled_by_id": cancelledById,
          "cancelled_at": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        },
      };

      final response = await http.put(
          Uri.parse(
              '${BookParkingEndPoints.cancelParkingSeatBooking}$bookingId.json?token=$token'),
          body: jsonEncode(body),
          headers: header);
      logInfo(msg: " result " + response.body.toString());

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }

      Util.showToast('Something went wrong, please try again later!');
      logError(msg: e.toString());
      return false;
    }
  }

  @override
  Future<ParkingSeatConfigurationDetailResponseModel?>
      getSeatConfigurationResponse({
    BuildContext? context,
    required String buildingId,
    required String floorId,
  }) async {
    CustomProgressDialog? pd;
    if (context != null) {
      pd = loadingPleaseWaitDialog(context: context);
      pd.show();
    }
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getParkingSeatConfigurationsListNew}$token&q[building_id_eq]=$buildingId&q[floor_id_eq]=$floorId';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getSeatConfigurationResponse\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = ParkingSeatConfigurationDetailResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        return null;
      }
    } catch (e) {
      if (pd != null && pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: 'Api getSeatConfigurationResponse Error: $e');
      return null;
    }
  }

  @override
  Future<bool> sendApprovalRequest({
    required BuildContext context,
    required String parkingConfigurationId,
    required DateTime selectDate,
  }) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final token = Prefs.getLockatedToken();

      Map<String, String> header = {
        'Authorization': token ?? '',
        'Content-Type': 'application/json;charset=UTF-8',
      };

      String tempDate = DateFormat("dd/MM/yyyy").format(selectDate);

      final response = await http.post(
          Uri.parse(
              '${BookParkingEndPoints.postParkingCreateApprovalRequest}$tempDate&parking_configuration_id=$parkingConfigurationId&token=$token'),
          headers: header);
      logInfo(msg: " result " + response.body.toString());

      if (response.statusCode == 200) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }

      Util.showToast('Something went wrong, please try again later!');
      logError(msg: e.toString());
      return false;
    }
  }

  @override
  Future<ParkingScheduleListResponseModel?> getSlots({
    required BuildContext context,
    required String seatConfigurationId,
    required DateTime selectedDate,
  }) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final tempDate = DateFormat("dd/MM/yyyy").format(selectedDate);
      final url =
          '${BookParkingEndPoints.getParkingSeatConfigurationsSlotsNew}$seatConfigurationId/get_schedules.json?token=$token&date=$tempDate';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(msg: 'getSlots\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = ParkingScheduleListResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        return null;
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: 'Api getSlots Error: $e');
      return null;
    }
  }

  @override
  Future<ParkingSeatBooking?> postBookSeatRequest({
    required BuildContext context,
    required bool isForRescheduling,
    required bool isWaitingListEnabled,
    required String bookingDate,
    required String parkingConfigurationId,
    required String parkingTimeSlotId,
    required String parkingNumberId,
    String? parkingBookingId = '',
  }) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final token = Prefs.getLockatedToken();

      Map<String, String> header = {
        "Content-Type": "application/json;charset=UTF-8",
        'Authorization': token ?? '',
      };
      Map<String, dynamic> body = {
        "parking_booking": {
          "booking_date": bookingDate,
          "status": isForRescheduling ? "rescheduled" : "confirmed",
          "parking_configuration_id": parkingConfigurationId,
          "parking_time_slot_id": parkingTimeSlotId,
          "parking_number_id": parkingNumberId,
        },
      };

      String url = '';
      if (!isWaitingListEnabled) {
        if (isForRescheduling) {
          url = BookParkingEndPoints.postParkingRescheduleSeatNew +
              (parkingBookingId ?? '') +
              "&token=$token";
        } else {
          url = '${BookParkingEndPoints.postParkingBookSeatNew}$token';
        }
      } else {
        // if (isForRescheduling) {
        //   url =
        //       '${EndPoints.postWaitListSeat}$token&seat_booking_id=$mSeatBookingId';
        // } else {
        //   url = '${EndPoints.postBookSeatNew}$token';
        // }
        if (isForRescheduling) {
          url = BookParkingEndPoints.postParkingRescheduleSeatNew +
              (parkingBookingId ?? '') +
              "&token=$token";
        } else {
          url = '${BookParkingEndPoints.postParkingBookSeatNew}$token';
        }
      }

      final response = await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: header);
      logInfo(
          msg:
              'postBookSeatRequest\nbody:$body \nstatusCode: ${response.statusCode} \nurl: $url\nheader: $header\nbody: $body\nresponse: ${response.body}\parking_configuration_id:$parkingConfigurationId\parkingTimeSlotId:$parkingTimeSlotId\parkingNumberId:$parkingNumberId');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = ParkingSeatBooking.fromJson(result);

        return res;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }

        return null;
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }

      Util.showToast('Something went wrong, please try again later!');
      logError(msg: e);
      return null;
    }
  }

  @override
  Future<ParkingSeatBooking?> getSeatBookingDetail(
      {required BuildContext context, required String bookingId}) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getParkingSeatBookingDetail}$bookingId.json?token=$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getSeatBookingDetail\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = ParkingSeatBooking.fromJson(result as Map<String, dynamic>);
        return res;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }
        return null;
      }
    } catch (e) {
      if (pd.isShowed) {
        pd.dismiss();
      }
      logError(msg: 'Api getSeatBookingDetail Error: $e');
      return null;
    }
  }

  @override
  Future<ResponseModel?> getParkingAutoCheckInOut({
    required String lockatedToken,
    required bool checkIn,
  }) async {
    try {
      final url =
          '${BookParkingEndPoints.parkingAutoCheckInOut}$lockatedToken&checked_in=$checkIn';
      final response = await getHttp(url: url, isTokenRequired: false, token: '');

      logInfo(
          msg:
              'getParkingAutoCheckInOut\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = ResponseModel.fromJson(result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getParkingAutoCheckInOut Error: $e');
      return null;
    }
  }
}








// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/book_parking_end_points.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_pkg_resident_urbanwork_widgets/core/constants/core_http.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:ndialog/ndialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';


// import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_response_model/floor_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_fixed_booked_available_count_response_model/parking_fixed_booked_available_count_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_schedule_list_response_model/parking_schedule_list_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_response_model/parking_seat_approval_request_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking_list_response_model/parking_seat_booking_list_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_response_model/parking_seat_configuration_detail_response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/response_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/loading_dialog.dart';



// class ParkingManagementRepository extends IParkingManagementRepository {
//   @override
//   Future<ParkingSeatBookingListResponseModel?> getSeatBookingList(
//       {BuildContext? context}) async {
//     CustomProgressDialog? pd;
//     if (context != null) {
//       pd = loadingPleaseWaitDialog(context: context);
//       pd.show();
//     }
//     try {
//       // final prefs = await SharedPreferences.getInstance();
//       String? token = Prefs.getLockatedToken();
//       if (token == null || token.isEmpty) {
//         token = Prefs.getLockatedSSOToken();
//       }
//     final url = '${BookParkingEndPoints.getParkingSeatBookingListNew}$token';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(
//           msg: 'getSeatBookingList\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);

//         final res = ParkingSeatBookingListResponseModel.fromJson(
//             result as Map<String, dynamic>);
//         return res;
//       } else {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         return null;
//       }
//     } catch (e) {
//       if (pd != null && pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: 'Api getSeatBookingList Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<BuildingResponseModel?> getBuildingList({required String date}) async {
//     try {
//       final token = Prefs.getLockatedToken() ?? '';
//       final url =
//           '${BookParkingEndPoints.getParkingManagementBuildingsList}$date&token=$token';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(msg: 'getBuildings\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body);

//         final res =
//             BuildingResponseModel.fromJson(result as Map<String, dynamic>);
//         return res;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       logError(msg: 'Api getBuildings Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<FloorResponseModel?> getFloors(
//       {required String date, required String buildingId}) async {
//     try {
//       final token = Prefs.getLockatedToken() ?? '';
//       final url =
//           '${BookParkingEndPoints.getParkingManagementFloorList}$buildingId&date=$date&token=$token';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(msg: 'getFloors\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body);

//         final res = FloorResponseModel.fromJson(result as Map<String, dynamic>);
//         return res;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       logError(msg: 'Api getFloors Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<ParkingFixedBookedAvailableCountResponseModel?>
//       getParkingManagementFixedBookedAvailableCountsList({
//     required String buildingId,
//     required String floorId,
//     required String date,
//   }) async {
//     try {
//       final token = Prefs.getLockatedToken() ?? '';
//       final url =
//           '${BookParkingEndPoints.getParkingManagementFixedBookedAvailableCountsList}building_id=$buildingId&floor_id=$floorId&date=$date&token=$token';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(
//           msg:
//               'getParkingManagementFixedBookedAvailableCountsList\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body);

//         final res = ParkingFixedBookedAvailableCountResponseModel.fromJson(
//             result as Map<String, dynamic>);
//         return res;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       logError(
//           msg:
//               'Api getParkingManagementFixedBookedAvailableCountsList Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<ParkingSeatApprovalRequestResponseModel?>
//       getSeatApprovalRequestList() async {
//     try {
//       final token = Prefs.getLockatedToken() ?? '';
//       final url = '${BookParkingEndPoints.getParkingSeatApprovalRequests}$token';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(
//           msg:
//               'getSeatApprovalRequestList\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body);

//         final res = ParkingSeatApprovalRequestResponseModel.fromJson(
//             result as Map<String, dynamic>);
//         return res;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       logError(msg: 'Api getSeatApprovalRequestList Error: $e');
//       return null;
//     }
//   }

//   //TODO
//   @override
//   Future<bool> sendPunchInDetails(
//       {BuildContext? context, required int slotId}) async {
//     CustomProgressDialog? pd;
//     if (context != null) {
//       pd = loadingPleaseWaitDialog(context: context);
//     }
//     if (pd != null) {
//       pd.show();
//     }
//     try {
//       // final prefs = await SharedPreferences.getInstance();
//       String? token = Prefs.getLockatedToken();
//       if (token == null || token.isEmpty) {
//         token = Prefs.getLockatedSSOToken();
//       }

//       Map<String, String> header = {
//         "Content-Type": "application/json;charset=UTF-8",
//         'Authorization': token ?? '',
//       };
//       Map<String, dynamic> body = {
//         "image": null,
//         "seat_booking_slot_id": slotId,
//       };

//       final response = await http.post(
//           Uri.parse(BookParkingEndPoints.sendParkingPunchInDetals),
//           body: jsonEncode(body),
//           headers: header);
//       logInfo(
//           msg:
//               'sendPunchInDetails \nurl: ${BookParkingEndPoints.sendParkingPunchInDetals}\nheader: $header\nbody: $body\nresponse: ${response.body}');

//       if (response.statusCode == 200) {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       } else {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       }
//     } catch (e) {
//       if (pd != null && pd.isShowed) {
//         pd.dismiss();
//       }

//       Util.showToast('Something went wrong, please try again later!');
//       logError(msg: e.toString());
//       return false;
//     }
//   }

//   //TODO
//   @override
//   Future<bool> sendPunchOutDetails(
//       {BuildContext? context,
//       required String attendanceId,
//       required String workLog}) async {
//     CustomProgressDialog? pd;
//     if (context != null) {
//       pd = loadingPleaseWaitDialog(context: context);
//     }
//     if (pd != null) {
//       pd.show();
//     }
//     try {
//       // final prefs = await SharedPreferences.getInstance();
//       String? token = Prefs.getLockatedToken();
//       if (token == null || token.isEmpty) {
//         token = Prefs.getLockatedSSOToken();
//       }

//       Map<String, String> header = {
//         'Authorization': token ?? '',
//       };
//       Map<String, dynamic> body = {
//         "work_log": workLog,
//       };

//       final response = await http.post(
//           Uri.parse(
//               '${BookParkingEndPoints.sendParkingPunchOutDetals}$attendanceId/punch_out.json?'),
//           body: jsonEncode(body),
//           headers: header);
//       logInfo(msg: body.toString() + " result " + response.body.toString());

//       if (response.statusCode == 200) {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       } else {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       }
//     } catch (e) {
//       if (pd != null && pd.isShowed) {
//         pd.dismiss();
//       }

//       Util.showToast('Something went wrong, please try again later!');
//       logError(msg: e.toString());
//       return false;
//     }
//   }

//   @override
//   Future<bool> sendCancelRequest({
//     required BuildContext context,
//     required String bookingId,
//     required String status,
//     required String cancelledById,
//   }) async {
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     try {
//       final token = Prefs.getLockatedToken();

//       Map<String, String> header = {
//         'Authorization': token ?? '',
//         'Content-Type': 'application/json;charset=UTF-8',
//       };

//       final body = {
//         "parking_booking": {
//           "status": status,
//           "cancelled_by_id": cancelledById,
//           "cancelled_at": DateFormat("yyyy-MM-dd").format(DateTime.now()),
//         },
//       };

//       final response = await http.put(
//           Uri.parse(
//               '${BookParkingEndPoints.cancelParkingSeatBooking}$bookingId.json?token=$token'),
//           body: jsonEncode(body),
//           headers: header);
//       logInfo(msg: " result " + response.body.toString());

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }

//       Util.showToast('Something went wrong, please try again later!');
//       logError(msg: e.toString());
//       return false;
//     }
//   }

//   @override
//   Future<ParkingSeatConfigurationDetailResponseModel?>
//       getSeatConfigurationResponse({
//     BuildContext? context,
//     required String buildingId,
//     required String floorId,
//   }) async {
//     CustomProgressDialog? pd;
//     if (context != null) {
//       pd = loadingPleaseWaitDialog(context: context);
//       pd.show();
//     }
//     try {
//       final token = Prefs.getLockatedToken() ?? '';
//       final url =
//           '${BookParkingEndPoints.getParkingSeatConfigurationsListNew}$token&q[building_id_eq]=$buildingId&q[floor_id_eq]=$floorId';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(
//           msg:
//               'getSeatConfigurationResponse\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);

//         final res = ParkingSeatConfigurationDetailResponseModel.fromJson(
//             result as Map<String, dynamic>);
//         return res;
//       } else {
//         if (pd != null && pd.isShowed) {
//           pd.dismiss();
//         }
//         return null;
//       }
//     } catch (e) {
//       if (pd != null && pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: 'Api getSeatConfigurationResponse Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<bool> sendApprovalRequest({
//     required BuildContext context,
//     required String parkingConfigurationId,
//     required DateTime selectDate,
//   }) async {
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     try {
//       final token = Prefs.getLockatedToken();

//       Map<String, String> header = {
//         'Authorization': token ?? '',
//         'Content-Type': 'application/json;charset=UTF-8',
//       };

//       String tempDate = DateFormat("dd/MM/yyyy").format(selectDate);

//       final response = await http.post(
//           Uri.parse(
//               '${BookParkingEndPoints.postParkingCreateApprovalRequest}$tempDate&parking_configuration_id=$parkingConfigurationId&token=$token'),
//           headers: header);
//       logInfo(msg: " result " + response.body.toString());

//       if (response.statusCode == 200) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);
//         if (result['error'] != null) {
//           Util.showToast('Something went wrong, please try again later!');
//           logError(msg: result['error'].toString());
//           return false;
//         } else {
//           return true;
//         }
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }

//       Util.showToast('Something went wrong, please try again later!');
//       logError(msg: e.toString());
//       return false;
//     }
//   }

//   @override
//   Future<ParkingScheduleListResponseModel?> getSlots({
//     required BuildContext context,
//     required String seatConfigurationId,
//     required DateTime selectedDate,
//   }) async {
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     try {
//       final token = Prefs.getLockatedToken() ?? '';
//       final tempDate = DateFormat("dd/MM/yyyy").format(selectedDate);
//       final url =
//           '${BookParkingEndPoints.getParkingSeatConfigurationsSlotsNew}$seatConfigurationId/get_schedules.json?token=$token&date=$tempDate';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(msg: 'getSlots\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);

//         final res = ParkingScheduleListResponseModel.fromJson(
//             result as Map<String, dynamic>);
//         return res;
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         return null;
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: 'Api getSlots Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<ParkingSeatBooking?> postBookSeatRequest({
//     required BuildContext context,
//     required bool isForRescheduling,
//     required bool isWaitingListEnabled,
//     required String bookingDate,
//     required String parkingConfigurationId,
//     required String parkingTimeSlotId,
//     required String parkingNumberId,
//     String? parkingBookingId = '',
//   }) async {
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     try {
//       final token = Prefs.getLockatedToken();

//       Map<String, String> header = {
//         "Content-Type": "application/json;charset=UTF-8",
//         'Authorization': token ?? '',
//       };
//       Map<String, dynamic> body = {
//         "parking_booking": {
//           "booking_date": bookingDate,
//           "status": isForRescheduling ? "rescheduled" : "confirmed",
//           "parking_configuration_id": parkingConfigurationId,
//           "parking_time_slot_id": parkingTimeSlotId,
//           "parking_number_id": parkingNumberId,
//         },
//       };

//       String url = '';
//       if (!isWaitingListEnabled) {
//         if (isForRescheduling) {
//           url = BookParkingEndPoints.postParkingRescheduleSeatNew +
//               (parkingBookingId ?? '') +
//               "&token=$token";
//         } else {
//           url = '${BookParkingEndPoints.postParkingBookSeatNew}$token';
//         }
//       } else {
//         // if (isForRescheduling) {
//         //   url =
//         //       '${EndPoints.postWaitListSeat}$token&seat_booking_id=$mSeatBookingId';
//         // } else {
//         //   url = '${EndPoints.postBookSeatNew}$token';
//         // }
//         if (isForRescheduling) {
//           url = BookParkingEndPoints.postParkingRescheduleSeatNew +
//               (parkingBookingId ?? '') +
//               "&token=$token";
//         } else {
//           url = '${BookParkingEndPoints.postParkingBookSeatNew}$token';
//         }
//       }

//       final response = await http.post(Uri.parse(url),
//           body: jsonEncode(body), headers: header);
//       logInfo(
//           msg:
//               'postBookSeatRequest\nbody:$body \nstatusCode: ${response.statusCode} \nurl: $url\nheader: $header\nbody: $body\nresponse: ${response.body}\parking_configuration_id:$parkingConfigurationId\parkingTimeSlotId:$parkingTimeSlotId\parkingNumberId:$parkingNumberId');

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);

//         final res = ParkingSeatBooking.fromJson(result);

//         return res;
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }

//         return null;
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }

//       Util.showToast('Something went wrong, please try again later!');
//       logError(msg: e);
//       return null;
//     }
//   }

//   //TODO
//   @override
//   Future<ParkingSeatBooking?> getSeatBookingDetail(
//       {required BuildContext context, required String bookingId}) async {
//     final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
//     pd.show();
//     try {
//       final token = Prefs.getLockatedToken() ?? '';
//       final url =
//           '${BookParkingEndPoints.getParkingSeatBookingDetail}$bookingId.json?token=$token';
//       final response = await getHttp(url: url, isTokenRequired: true, token: '');

//       logInfo(
//           msg:
//               'getSeatBookingDetail\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         final result = jsonDecode(response.body);

//         final res = ParkingSeatBooking.fromJson(result as Map<String, dynamic>);
//         return res;
//       } else {
//         if (pd.isShowed) {
//           pd.dismiss();
//         }
//         return null;
//       }
//     } catch (e) {
//       if (pd.isShowed) {
//         pd.dismiss();
//       }
//       logError(msg: 'Api getSeatBookingDetail Error: $e');
//       return null;
//     }
//   }

//   @override
//   Future<ResponseModel?> getParkingAutoCheckInOut({
//     required String lockatedToken,
//     required bool checkIn,
//   }) async {
//     try {
//       final url =
//           '${BookParkingEndPoints.parkingAutoCheckInOut}$lockatedToken&checked_in=$checkIn';
//       final response = await getHttp(url: url, isTokenRequired: false, token: '');

//       logInfo(
//           msg:
//               'getParkingAutoCheckInOut\n url: $url \n response: ${response.body}');
//       if (response.statusCode == 200) {
//         final result = jsonDecode(response.body);

//         final res = ResponseModel.fromJson(result as Map<String, dynamic>);
//         return res;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       logError(msg: 'Api getParkingAutoCheckInOut Error: $e');
//       return null;
//     }
//   }
// }
