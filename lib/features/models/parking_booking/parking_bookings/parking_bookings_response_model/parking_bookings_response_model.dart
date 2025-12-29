import 'package:json_annotation/json_annotation.dart';

import '../parking_bookings_model/parking_bookings_model.dart';

part 'parking_bookings_response_model.g.dart';

@JsonSerializable()
class ParkingBookingsResponseModel {
  @JsonKey(name: 'parking_bookings')
  final List<ParkingBookingsModel>? parkingBookings;
  @JsonKey(name: 'code')
  final int? code;

  ParkingBookingsResponseModel({
    this.parkingBookings,
    this.code,
  });

  factory ParkingBookingsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingBookingsResponseModelFromJson(json);

  Map<String, dynamic> toJosn() => _$ParkingBookingsResponseModelToJson(this);
}
