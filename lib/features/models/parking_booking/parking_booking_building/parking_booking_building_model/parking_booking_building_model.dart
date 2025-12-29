import 'package:json_annotation/json_annotation.dart';

import '../parking_booking_floor_model/parking_booking_floor_model.dart';

part 'parking_booking_building_model.g.dart';

@JsonSerializable()
class ParkingBookingBuildingModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'has_wing')
  final bool? hasWing;
  @JsonKey(name: 'has_floor')
  final bool? hasFloor;
  @JsonKey(name: 'has_area')
  final bool? hasArea;
  @JsonKey(name: 'has_room')
  final bool? hasRoom;
  @JsonKey(name: 'floors')
  final List<ParkingBookingFloorModel>? floors;
  @JsonKey(name: 'available_seats')
  final int? availableSeats;
  @JsonKey(name: 'available_parkings')
  final int? availableParkings;

  ParkingBookingBuildingModel({
    this.id,
    this.name,
    this.hasWing,
    this.hasFloor,
    this.hasArea,
    this.hasRoom,
    this.floors,
    this.availableSeats,
    this.availableParkings,
  });

  factory ParkingBookingBuildingModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingBookingBuildingModelFromJson(json);

  Map<String, dynamic> toJosn() => _$ParkingBookingBuildingModelToJson(this);
}
