import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_schedule_list/parking_slot_model/parking_slot_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_model/parking_seat_configuration_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_schedule_list_response_model.g.dart';

@JsonSerializable()
class ParkingScheduleListResponseModel {
  @JsonKey(name: 'parking_configuration')
  final ParkingSeatConfigurationModel? parkingConfiguration;
  List<ParkingSlotModel>? slots;
  @JsonKey(name: 'booked_slots')
  List<ParkingSlotModel>? bookedSlots;

  final int? code;
  final dynamic message;

  ParkingScheduleListResponseModel({
    this.parkingConfiguration,
    this.slots,
    this.bookedSlots,
    this.code,
    this.message,
  });

  factory ParkingScheduleListResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingScheduleListResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkingScheduleListResponseModelToJson(this);
}
