import 'package:json_annotation/json_annotation.dart';

import '../parking_booking_schedules_parking_configuration_model/parking_booking_schedules_parking_configuration_model.dart';
import '../parking_booking_schedules_slot_model/parking_booking_schedules_slot_model.dart';

part 'parking_booking_schedules_response_model.g.dart';

@JsonSerializable()
class ParkingBookingSchedulesResponseModel {
  @JsonKey(name: 'parking_configuration')
  final ParkingBookingSchedulesParkingConfigurationModel? parkingConfiguration;
  @JsonKey(name: 'slots')
  final List<ParkingBookingSchedulesSlotModel>? slots;
  @JsonKey(name: 'booked_slots')
  final List<dynamic>? bookedSlots;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final dynamic message;

  ParkingBookingSchedulesResponseModel({
    this.parkingConfiguration,
    this.slots,
    this.bookedSlots,
    this.code,
    this.message,
  });

  factory ParkingBookingSchedulesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingBookingSchedulesResponseModelFromJson(json);

  Map<String, dynamic> toJosn() =>
      _$ParkingBookingSchedulesResponseModelToJson(this);
}
