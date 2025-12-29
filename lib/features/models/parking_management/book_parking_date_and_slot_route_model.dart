import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';

class BookParkingDateAndSlotRouteModel {
  final ParkingSeatConfigurationDetailModel? seatConfiguration;
  final DateTime? selectDay;
  final BuildingModel? building;
  final FloorModel? floor;
  final bool isForRescheduling;
  final ParkingSeatBooking? mSeatBooking;

  BookParkingDateAndSlotRouteModel({
    this.seatConfiguration,
    this.selectDay,
    this.building,
    this.floor,
    this.isForRescheduling = false,
    this.mSeatBooking,
  });
}
