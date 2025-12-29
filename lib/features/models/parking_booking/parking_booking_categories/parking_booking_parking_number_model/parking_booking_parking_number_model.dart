
import 'package:json_annotation/json_annotation.dart';

part 'parking_booking_parking_number_model.g.dart';

@JsonSerializable()
class ParkingBookingParkingNumberModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'active')
  final bool? active;

  ParkingBookingParkingNumberModel({
    this.id,
    this.name,
    this.active,
  });

  factory ParkingBookingParkingNumberModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingBookingParkingNumberModelFromJson(json);

  Map<String, dynamic> toJosn() =>
      _$ParkingBookingParkingNumberModelToJson(this);
}
