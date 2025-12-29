import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/book_parking_end_points.dart';
import 'package:flutter_pkg_resident_urbanwork_widgets/core/constants/core_http.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_bookings_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_book_parking/parking_booking_book_parking_response_model/parking_booking_book_parking_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_response_model/parking_booking_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_schedules/parking_booking_schedules_response_model/parking_booking_schedules_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_bookings_response_model/parking_bookings_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_categories_model/parking_categories_model.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/loading_dialog.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';

class ParkingBookingsRepository extends IParkingBookingsRepository {
  @override
  Future<ParkingBookingBookParkingResponseModel?> bookParking({
    required String bookingDate,
    required String parkingConfigurationId,
    required List<int> selectedSlots,
    required double minTime,
    required double maxTime,
    required BuildContext parentContext,
  }) async {
    final CustomProgressDialog pd =
        loadingPleaseWaitDialog(context: parentContext);
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
          "status": "confirmed",
          "parking_configuration_id": parkingConfigurationId,
          "start_time": minTime.toInt(),
          "end_time": maxTime.toInt(),
        },
        "selected_slots": selectedSlots
      };

      final url = '${BookParkingEndPoints.bookParkingBooking}&token=$token';

      final response = await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: header);
      logInfo(
          msg:
              'postBookSeatRequest\nbody:$body \nstatusCode: ${response.statusCode} \nurl: $url\nheader: $header\nbody: $body\nresponse: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = ParkingBookingBookParkingResponseModel.fromJson(result);

        return res;
      } else {
        if (pd.isShowed) {
          pd.dismiss();
        }

        final data = jsonDecode(response.body);

        // Extract error message
        final errorMessage = data["errors"]?[0] ?? "Something went wrong";
        showToastDialog(msg: errorMessage);

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
  Future<ParkingBookingBuildingsResponseModel?> getBuildings({
    required String currentDate,
    String? categoryId,
  }) async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      String url =
          '${BookParkingEndPoints.getParkingBookingBuildings}$currentDate&token=$token';
      if (categoryId != null) {
        url += '&category_id=$categoryId';
      }

      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(msg: 'getBuildings\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = ParkingBookingBuildingsResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getBuildings Error: $e');
      return null;
    }
  }

  // @override
  // Future<ParkingBookingCategoriesResponseModel?> getCategories({
  //   required String buildingId,
  //   required String floorId,
  // }) async {
  //   try {
  //     final token = Prefs.getLockatedToken() ?? '';
  //     final url =
  //         '${EndPoints.getParkingBookingCategories}$buildingId&token=$token&q[building_id_eq]=$buildingId&q[floor_id_eq]=$floorId';
  //     final response = await getHttp(url: url, isTokenRequired: true);

  //     logInfo(msg: 'getCategories\n url: $url \n response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(response.body);

  //       final res = ParkingBookingCategoriesResponseModel.fromJson(
  //           result as Map<String, dynamic>);
  //       return res;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     logError(msg: 'Api getCategories Error: $e');
  //     return null;
  //   }
  // }

  @override
  Future<List<ParkingCategoriesModel>?> getCategories() async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final siteId = Prefs.getSiteid();
      final url = '${BookParkingEndPoints.getParkingCategories}?token=$token';
      //final url = '${BookParkingEndPoints.getParkingCategories}?token=$token&site_id=$siteId';
      
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

  //final response = await getHttp(url: url, isTokenRequired: true, token: token);
      logInfo(msg: 'getCategories\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);

        final res = result
            .map((item) => ParkingCategoriesModel.fromJson(item))
            .toList();
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getCategories Error: $e');
      return null;
    }
  }

  @override
  Future<ParkingBookingsResponseModel?> getParkingList() async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url = '${BookParkingEndPoints.bookParkingBooking}token=$token';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(msg: 'getParkingList\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = ParkingBookingsResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getParkingList Error: $e');
      return null;
    }
  }

  @override
  Future<ParkingBookingSchedulesResponseModel?> getSchedules({
    required String parkingConfigurationId,
    required String currentDate,
  }) async {
    try {
      final token = Prefs.getLockatedToken() ?? '';
      final url =
          '${BookParkingEndPoints.getParkingBookingSchedules}$parkingConfigurationId/get_schedules.json?token=$token&date=$currentDate';
      final response = await getHttp(url: url, isTokenRequired: true, token: '');

      logInfo(msg: 'getSchedules\n url: $url \n response: ${response.body}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final res = ParkingBookingSchedulesResponseModel.fromJson(
            result as Map<String, dynamic>);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      logError(msg: 'Api getSchedules Error: $e');
      return null;
    }
  }

  @override
  Future<ParkingBookingBookParkingResponseModel?> cancelParking({
    required String id,
    required BuildContext parentContext,
  }) async {
    final CustomProgressDialog pd =
        loadingPleaseWaitDialog(context: parentContext);
    pd.show();
    try {
      final token = Prefs.getLockatedToken();

      Map<String, String> header = {
        "Content-Type": "application/json;charset=UTF-8",
        'Authorization': token ?? '',
      };
      final cancellationDateTime = DateTime.now().toIso8601String();

      final cancelledById = Prefs.getUserId();

      Map<String, dynamic> body = {
        "parking_booking": {
          "status": "cancelled",
          "cancelled_by_id": cancelledById,
          "cancelled_at": cancellationDateTime
        }
      };

      final url = '${BookParkingEndPoints.bookParkingCancelBooking}$id.json?&token=$token';

      final response = await http.put(Uri.parse(url),
          body: jsonEncode(body), headers: header);
      // logInfo(
      //     msg:
      //         'postBookSeatRequest\nbody:$body \nstatusCode: ${response.statusCode} \nurl: $url\nheader: $header\nbody: $body\nresponse: ${response.body}\parking_configuration_id:$parkingConfigurationId\parkingTimeSlotId:$parkingTimeSlotId\parkingNumberId:$parkingNumberId');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (pd.isShowed) {
          pd.dismiss();
        }
        final result = jsonDecode(response.body);

        final res = ParkingBookingBookParkingResponseModel.fromJson(result);

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
}
