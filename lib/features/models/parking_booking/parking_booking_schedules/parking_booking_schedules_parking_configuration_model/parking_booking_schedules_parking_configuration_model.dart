import 'package:json_annotation/json_annotation.dart';

part 'parking_booking_schedules_parking_configuration_model.g.dart';

@JsonSerializable()
class ParkingBookingSchedulesParkingConfigurationModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'building_id')
  final int? buildingId;
  @JsonKey(name: 'floor_id')
  final int? floorId;
  @JsonKey(name: 'parking_category')
  final String? parkingCategory;
  @JsonKey(name: 'total_parkings')
  final int? totalParkings;
  @JsonKey(name: 'available_parkings')
  final int? availableParkings;
  @JsonKey(name: 'booked_parkings')
  final int? bookedParkings;

  ParkingBookingSchedulesParkingConfigurationModel({
    this.id,
    this.buildingId,
    this.floorId,
    this.parkingCategory,
    this.totalParkings,
    this.availableParkings,
    this.bookedParkings,
  });

  factory ParkingBookingSchedulesParkingConfigurationModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingBookingSchedulesParkingConfigurationModelFromJson(json);

  Map<String, dynamic> toJosn() =>
      _$ParkingBookingSchedulesParkingConfigurationModelToJson(this);
}
