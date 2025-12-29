import 'dart:async';
import 'dart:math';

// import 'package:background_locator_2/location_dto.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_go_phygital/core/repository/i_parking_management_repository.dart';
// import 'package:flutter_go_phygital/repository/parking_management_repository.dart';
// import 'package:flutter_go_phygital/screens/splash_screen/splash_screen.dart';
// import 'package:flutter_go_phygital/utils/custom_logger.dart';
// import 'package:flutter_go_phygital/utils/prefs.dart';
// import 'package:flutter_go_phygital/utils/utils.dart';
// import 'package:flutter_go_phygital/widgets/common/toast_dialog.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/i_parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/features/repository/parking_management_repository.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationServiceRepository {
  static LocationServiceRepository _instance = LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  // static const String isolateName = 'LocatorIsolate';

  // int _count = -1;

  // Future<void> init(Map<dynamic, dynamic> params) async {
  //   //TODO change logs
  //   print("***********Init callback handler");
  //   if (params.containsKey('countInit')) {
  //     dynamic tmpCount = params['countInit'];
  //     if (tmpCount is double) {
  //       _count = tmpCount.toInt();
  //     } else if (tmpCount is String) {
  //       _count = int.parse(tmpCount);
  //     } else if (tmpCount is int) {
  //       _count = tmpCount;
  //     } else {
  //       _count = -2;
  //     }
  //   } else {
  //     _count = 0;
  //   }
  //   print("$_count");
  //   await setLogLabel("start");
  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(null);
  // }

  // Future<void> dispose() async {
  //   print("***********Dispose callback handler");
  //   print("$_count");
  //   await setLogLabel("end");
  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(null);
  // }

  // - Old Code -

  // Future<void> callback(LocationDto locationDto) async {
  //   print('$_count location in dart: ${locationDto.toString()}');
  //   await setLogPosition(_count, locationDto);
  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(locationDto.toString());
  //   _count++;
  // print('$_count location in dart: ${locationDto.toString()}');
  // await setLogPosition(_count, locationDto);
  // final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  // send?.send(locationDto.toString());
  // _count++;

  // bool isGeofence = await setGeoFencing(
  //   currentLatitude: locationDto.latitude,
  //   currentLongitude: locationDto.longitude,
  // );

  // - Old code End -

  Future<void> callback({
    required double lat,
    required double long,
  }) async {
    bool isGeofence = await setGeoFencing(
      currentLatitude: lat,
      currentLongitude: long,
    );

    final prefs = await SharedPreferences.getInstance();

    String lockatedToken = prefs.getString(Prefs.lockatedToken) ?? '';

    String? parkingAutoCheckInDate =
        prefs.getString(Prefs.parkingAutoCheckInDate);

    bool isCheckedIn = prefs.getBool(Prefs.parkingAutoCheckedIn) ?? false;
    bool isCheckOut = prefs.getBool(Prefs.parkingAutoCheckedOut) ?? false;

    bool shouldCallApi = false;

    if (parkingAutoCheckInDate == null || parkingAutoCheckInDate.isEmpty) {
      if (isGeofence) {
        shouldCallApi = true;
      }
    } else {
      DateTime checkedDate =
          DateFormat('yyyy-MM-dd').parse(parkingAutoCheckInDate);
      bool isToday = Utils.isToday(date: checkedDate);
      if (isToday) {
        if (isGeofence) {
          if (!isCheckedIn && !isCheckOut) {
            shouldCallApi = true;
          }
        } else {
          if (isCheckedIn && !isCheckOut) {
            shouldCallApi = true;
          }
        }
      } else {
        if (isGeofence) {
          shouldCallApi = true;
        }
      }
    }

    if (shouldCallApi) {
      DateTime now = DateTime.now();
      await prefs.setString(
          Prefs.parkingAutoCheckInDate, '${now.year}-${now.month}-${now.day}');
      IParkingManagementRepository repository = ParkingManagementRepository();
      final response = await repository.getParkingAutoCheckInOut(
        lockatedToken: lockatedToken,
        checkIn: isGeofence,
      );
      // if (response?.code != null && response!.code == 200) {
      //   if (response.message != null) {
      //     showToastDialog(msg: response.message!);
      //     flutterLocalNotificationsPlugin.show(
      //       Random().nextInt(100),
      //       'Parking',
      //       response.message!,
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           color: Colors.blue,
      //           playSound: true,
      //           icon: '@mipmap/ic_launcher',
      //         ),
      //       ),
      //     );
      //     if (response.message!.toLowerCase().contains('parked already')) {
      //       await prefs.setBool(Prefs.parkingAutoCheckedIn, true);
      //     } else if (response.message!
      //             .toLowerCase()
      //             .contains('already exited') ||
      //         response.message!.toLowerCase().contains('alredy exited')) {
      //       await prefs.setBool(Prefs.parkingAutoCheckedOut, true);
      //     } else if (response.message!.toLowerCase().contains('parked')) {
      //       await prefs.setBool(Prefs.parkingAutoCheckedIn, true);
      //     } else if (response.message!.toLowerCase().contains('exited')) {
      //       await prefs.setBool(Prefs.parkingAutoCheckedOut, true);
      //     }
      //   }
      //   // if (isCheckedIn) {
      //   //   showToastDialog(msg: 'Your vehicle has excited the complex');
      //   //   await prefs.setBool(Prefs.parkingAutoCheckedOut, true);
      //   // } else {
      //   //   showToastDialog(msg: 'Your vechile has been parked!');
      //   //   await prefs.setBool(Prefs.parkingAutoCheckedIn, true);
      //   // }
      // }
      logInfo(
          msg:
              'inGeofence: $isGeofence\nisCheckIn: $isCheckedIn\nisCheckOut: $isCheckOut\nres: $response\nparkingAutoCheckInDate:$parkingAutoCheckInDate');
    } else {
      logInfo(
          msg:
              'inGeofence: $isGeofence\nisCheckIn: $isCheckedIn\nisCheckOut: $isCheckOut\nparkingAutoCheckInDate:$parkingAutoCheckInDate\nshouldCallApi:$shouldCallApi');
    }
  }

  // static Future<void> setLogLabel(String label) async {
  //   final date = DateTime.now();
  //   await FileManager.writeToLogFile(
  //       '------------\n$label: ${formatDateLog(date)}\n------------\n');
  // }

  // static Future<void> setLogPosition(int count, LocationDto data) async {
  //   final date = DateTime.now();
  //   await FileManager.writeToLogFile(
  //       '$count : ${formatDateLog(date)} --> ${formatLog(data)} --- isMocked: ${data.isMocked}\n');
  // }

  // static double dp(double val, int places) {
  //   final mod = pow(10.0, places);
  //   return ((val * mod).round().toDouble() / mod);
  // }

  // static String formatDateLog(DateTime date) {
  //   return date.hour.toString() +
  //       ":" +
  //       date.minute.toString() +
  //       ":" +
  //       date.second.toString();
  // }

  // static String formatLog(LocationDto locationDto) {
  //   return dp(locationDto.latitude, 4).toString() +
  //       " " +
  //       dp(locationDto.longitude, 4).toString();
  // }

  Future<bool> setGeoFencing({
    required double currentLatitude,
    required double currentLongitude,
  }) async {
    bool tempValue = false;
    double latitude = 0;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Prefs.pmsSiteLatitude) != null) {
      latitude = double.parse(prefs.getString(Prefs.pmsSiteLatitude) ?? '');
    }

    double longitude = 0;
    if (prefs.getString(Prefs.pmsSiteLongitude) != null) {
      longitude = double.parse(prefs.getString(Prefs.pmsSiteLongitude) ?? '');
    }

    double distanceInMeters = Geolocator.distanceBetween(
        currentLatitude, currentLongitude, latitude, longitude);
    double pmsSiteGeofenceInMeters = double.parse(
      prefs.getDouble(Prefs.pmsSetGeoFence) == null
          ? '0'
          : prefs.getDouble(Prefs.pmsSetGeoFence).toString(),
    ); // this is in meters

    logInfo(
        msg:
            'currentLat: $currentLatitude \ncurrentLong: $currentLongitude\nlatitude: $latitude\nlogitude: $longitude\nDistanceInMeters: $distanceInMeters\npmsSiteGeoFenceInMeters: $pmsSiteGeofenceInMeters');

    if (pmsSiteGeofenceInMeters != 0) {
      if (distanceInMeters <= pmsSiteGeofenceInMeters) {
        // showToastDialog(msg: 'You are in Geofence area.');
        logInfo(msg: 'You are in Geofence area.');
        tempValue = true;
      } else {
        logInfo(msg: 'You are outside Geofence area.');
        tempValue = false;
      }
    } else {
      tempValue = false;
    }
    return tempValue;
  }
}
