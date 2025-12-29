import 'package:json_annotation/json_annotation.dart';

import '../parking_booking_building_model/parking_booking_building_model.dart';

part 'parking_booking_response_model.g.dart';

@JsonSerializable()
class ParkingBookingBuildingsResponseModel {
  @JsonKey(name: 'buildings')
  final List<ParkingBookingBuildingModel>? buildings;
  @JsonKey(name: 'code')
  final int? code;

  ParkingBookingBuildingsResponseModel({
    this.buildings,
    this.code,
  });

  factory ParkingBookingBuildingsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingBookingBuildingsResponseModelFromJson(json);

  Map<String, dynamic> toJosn() => _$ParkingBookingBuildingsResponseModelToJson(this);
}
