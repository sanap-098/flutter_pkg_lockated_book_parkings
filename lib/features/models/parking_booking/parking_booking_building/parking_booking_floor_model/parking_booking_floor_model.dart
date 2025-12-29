import 'package:json_annotation/json_annotation.dart';

part 'parking_booking_floor_model.g.dart';

@JsonSerializable()
class ParkingBookingFloorModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'available_parkings')
  final int? availableParkings;
  @JsonKey(name: 'floor_plan_attachment')
  final String? floorPlanAttachment;
  @JsonKey(name: 'configuration_id')
  final int? configurationId;

  ParkingBookingFloorModel({
    this.id,
    this.name,
    this.availableParkings,
    this.floorPlanAttachment,
    this.configurationId,
  });

  factory ParkingBookingFloorModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingBookingFloorModelFromJson(json);

  Map<String, dynamic> toJosn() => _$ParkingBookingFloorModelToJson(this);
}
