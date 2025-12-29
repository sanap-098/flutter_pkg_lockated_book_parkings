import 'package:json_annotation/json_annotation.dart';

import '../parking_booking_parking_configuration_model/parking_booking_parking_configuration_model.dart';

part 'parking_booking_categories_response_model.g.dart';

@JsonSerializable()
class ParkingBookingCategoriesResponseModel {
  @JsonKey(name: 'parking_configuration')
  final List<ParkingBookingParkingConfigurationModel>? parkingConfiguration;
  @JsonKey(name: 'code')
  final int? code;

  ParkingBookingCategoriesResponseModel({
    this.parkingConfiguration,
    this.code,
  });

  factory ParkingBookingCategoriesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingBookingCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJosn() =>
      _$ParkingBookingCategoriesResponseModelToJson(this);
}
