import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_categories_model/parking_categories_model.dart';

import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_book_parking/parking_booking_book_parking_response_model/parking_booking_book_parking_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_response_model/parking_booking_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_categories/parking_booking_categories_response_model/parking_booking_categories_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_schedules/parking_booking_schedules_response_model/parking_booking_schedules_response_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_bookings/parking_bookings_response_model/parking_bookings_response_model.dart';
abstract class IParkingBookingsRepository {
  Future<ParkingBookingBuildingsResponseModel?> getBuildings({
    required String currentDate,
    String? categoryId,
  });

  Future<List<ParkingCategoriesModel>?> getCategories();

  Future<ParkingBookingSchedulesResponseModel?> getSchedules({
    required String parkingConfigurationId,
    required String currentDate,
  });

  Future<ParkingBookingBookParkingResponseModel?> bookParking({
    required String bookingDate,
    required String parkingConfigurationId,
    required List<int> selectedSlots,
    required double minTime,
    required double maxTime,
    required BuildContext parentContext,
  });

  Future<ParkingBookingBookParkingResponseModel?> cancelParking({
    required String id,
    required BuildContext parentContext,
  });

  Future<ParkingBookingsResponseModel?> getParkingList();
}
