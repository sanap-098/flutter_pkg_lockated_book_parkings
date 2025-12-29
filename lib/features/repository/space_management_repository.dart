import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/book_parking_end_points.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/building_response_model/building_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/fixed_booked_available_count_response/fixed_booked_available_count_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_response_model/floor_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/put_cancel_slots_request_parameters/put_cancel_slots_request_parameters.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/response_model/seat_booking_list_response_model/seat_booking_list_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_approval_request/seat_approval_request_response_model/seat_approval_request_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_configuration_detail_response_model/seat_configuration_detail_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_space_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/loading_dialog.dart';
import 'package:flutter_pkg_resident_urbanwork_widgets/core/constants/core_http.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

import 'package:http/http.dart' as http;

class SpaceManagementRepository extends ISpaceManagementRepository {
  @override
  Future<SeatBookingListResponseModel?> getSeatBookingList(
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
      final url = '${BookParkingEndPoints.getSeatBookingListNew}$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg: 'getSeatBookingList\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = SeatBookingListResponseModel.fromJson(
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
          '${BookParkingEndPoints.getSpaceManagementBuildingsList}$date&token=$token';
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
          '${BookParkingEndPoints.getSpaceManagementFloorList}$buildingId&date=$date&token=$token';
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
  Future<FixedBookedAvailableCountResponseModel?>
      getSpaceManagementFixedBookedAvailableCountsList({
    required String buildingId,
    required String floorId,
    required String date,
  }) async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getSpaceManagementFixedBookedAvailableCountsList}building_id=$buildingId&floor_id=$floorId&date=$date&token=$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getSpaceManagementFixedBookedAvailableCountsList\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = FixedBookedAvailableCountResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(
          msg:
              'Api getSpaceManagementFixedBookedAvailableCountsList Error: $e');
      return null;
    }
  }

  @override
  Future<SeatApprovalRequestResponseModel?> getSeatApprovalRequestList() async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url = '${BookParkingEndPoints.getSeatApprovalRequests}$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getSeatApprovalRequestList\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = SeatApprovalRequestResponseModel.fromJson(
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
  Future<bool> sendPunchInDetails({
    BuildContext? context,
    required int slotId,
    int? parkingBookingId,
  }) async {
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

      Map<String, dynamic> body = {};

      if (parkingBookingId != null) {
        body = {
          "image": null,
          "parking_booking_id": parkingBookingId,
        };
      } else {
        body = {
          "image": null,
          "seat_booking_slot_id": slotId,
        };
      }

      final response = await http.post(Uri.parse(BookParkingEndPoints.sendPunchInDetals),
          body: jsonEncode(body), headers: header);
      logInfo(
          msg:
              'sendPunchInDetails \nurl: ${BookParkingEndPoints.sendPunchInDetals}\nheader: $header\nbody: $body\nresponse: ${response.body}');
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
  Future<bool> sendPunchOutDetails({
    BuildContext? context,
    required String attendanceId,
    required String workLog,
    int? parkingBookingId,
  }) async {
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
      if (parkingBookingId != null) {
        body['parking_booking_id'] = parkingBookingId;
      }

      final response = await http.post(
          Uri.parse(
              '${BookParkingEndPoints.sendPunchOutDetals}$attendanceId/punch_out.json?'),
          body: jsonEncode(body),
          headers: header);
      logInfo(msg: "$body result ${response.body}");

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
  Future<bool> sendCancelRequest(
      {required BuildContext context,
      required String bookingId,
      required PutCancelSlotSRequestParameters request}) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final token = Prefs.getLockatedToken();

      Map<String, String> header = {
        'Authorization': token ?? '',
        'Content-Type': 'application/json;charset=UTF-8',
      };

      final response = await http.put(
          Uri.parse(
              '${BookParkingEndPoints.cancelSeatBooking}$bookingId/cancel_slots.json?token=$token'),
          body: jsonEncode(request),
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
  Future<SeatConfigurationDetailResponseModel?> getSeatConfigurationResponse({
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
          '${BookParkingEndPoints.getSeatConfigurationsListNew}$token&q[building_id_eq]=$buildingId&q[floor_id_eq]=$floorId';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getSeatConfigurationResponse\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        if (pd != null && pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = SeatConfigurationDetailResponseModel.fromJson(
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
    required String seatConfigurationId,
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
              '${BookParkingEndPoints.postCreateApprovalRequest}$tempDate&seat_configuration_id=$seatConfigurationId&token=$token'),
          headers: header);
      logInfo(msg: " result " + response.body.toString());

      if (response.statusCode == 200) {
        await logEvents(name: 'seat_management_request_success');
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          Util.showToast('Something went wrong, please try again later!');
          logError(msg: result['error'].toString());
          await logEvents(
              name: 'seat_management_request_failure',
              parameters: {'error': result['error']});
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

  // @override
  // Future<ScheduleListResponseModel?> getSlots({
  //   required BuildContext context,
  //   required String seatConfigurationId,
  //   required DateTime selectedDate,
  // }) async {
  //   final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
  //   pd.show();
  //   try {
  //     final token = Prefs.getLockatedToken() ?? '';
  //     final tempDate = DateFormat("dd/MM/yyyy").format(selectedDate);
  //     final url =
  //         '${BookParkingEndPoints.getSeatConfigurationsSlotsNew}$seatConfigurationId/get_schedules.json?token=$token&date=$tempDate';
  //     final response = await getHttp(url: url, isTokenRequired: true, token: '');

  //     logInfo(msg: 'getSlots\n url: $url \n response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       if (pd.isShowed) {
  //         pd.dismiss();
  //       }
  //       final result = jsonDecode(response.body);

  //       final res =
  //           ScheduleListResponseModel.fromJson(result as Map<String, dynamic>);
  //       return res;
  //     } else {
  //       if (pd.isShowed) {
  //         pd.dismiss();
  //       }
  //       return null;
  //     }
  //   } catch (e) {
  //     if (pd.isShowed) {
  //       pd.dismiss();
  //     }
  //     logError(msg: 'Api getSlots Error: $e');
  //     return null;
  //   }
  // }

  // @override
  // Future<SeatBooking?> postBookSeatRequest({
  //   required BuildContext context,
  //   required PostBookingRequestModel request,
  //   required bool isForRescheduling,
  //   required bool isWaitingListEnabled,
  //   String mSeatBookingId = '',
  // }) async {
  //   final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
  //   pd.show();
  //   try {
  //     final token = Prefs.getLockatedToken();

  //     Map<String, String> header = {
  //       "Content-Type": "application/json;charset=UTF-8",
  //       'Authorization': token ?? '',
  //     };
  //     Map<String, dynamic> body = request.toJson();

  //     String url = '';
  //     if (!isWaitingListEnabled) {
  //       if (isForRescheduling) {
  //         url = BookParkingEndPoints.postRescheduleSeatNew +
  //             mSeatBookingId +
  //             "&token=$token";
  //       } else {
  //         url = '${BookParkingEndPoints.postBookSeatNew}$token';
  //       }
  //     } else {
  //       if (isForRescheduling) {
  //         url =
  //             '${BookParkingEndPoints.postWaitListSeat}$token&seat_booking_id=$mSeatBookingId';
  //       } else {
  //         url = '${BookParkingEndPoints.postBookSeatNew}$token';
  //       }
  //     }

  //     final response = await http.post(Uri.parse(url),
  //         body: jsonEncode(body), headers: header);
  //     logInfo(
  //         msg:
  //             'postBookSeatRequest \nstatusCode: ${response.statusCode} \nurl: ${EndPoints.sendPunchInDetals}\nheader: $header\nbody: $body\nresponse: ${response.body}\nslot_id:${request.selectedSlots![0].slotId}\nseat_id:${request.selectedSlots![0].seatId}\nconfig_id:${request.seatBooking?.seatConfigurationId}');

  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       if (pd.isShowed) {
  //         pd.dismiss();
  //       }
  //       final result = jsonDecode(response.body);

  //       final res = SeatBooking.fromJson(result);

  //       return res;
  //     } else {
  //       if (pd.isShowed) {
  //         pd.dismiss();
  //       }

  //       return null;
  //     }
  //   } catch (e) {
  //     if (pd.isShowed) {
  //       pd.dismiss();
  //     }

  //     Util.showToast('Something went wrong, please try again later!');
  //     logError(msg: e.toString());
  //     return null;
  //   }
  // }

  @override
  Future<SeatBooking?> getSeatBookingDetail(
      {required BuildContext context, required String bookingId}) async {
    final CustomProgressDialog pd = loadingPleaseWaitDialog(context: context);
    pd.show();
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getSeatBookingDetail}$bookingId.json?token=$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(
          msg:
              'getSeatBookingDetail\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = SeatBooking.fromJson(result as Map<String, dynamic>);
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
}
