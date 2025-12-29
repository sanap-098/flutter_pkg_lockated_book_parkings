
import 'package:json_annotation/json_annotation.dart';

import '../parking_booking_parking_number_model/parking_booking_parking_number_model.dart';

part 'parking_booking_parking_configuration_model.g.dart';

@JsonSerializable()
class ParkingBookingParkingConfigurationModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'resource_id')
  final int? resourceId;
  @JsonKey(name: 'resource_type')
  final String? resourceType;
  @JsonKey(name: 'no_of_parkings')
  final int? noOfParkings;
  @JsonKey(name: 'created_by_id')
  final int? createdById;
  @JsonKey(name: 'parking_numbers')
  final List<ParkingBookingParkingNumberModel>? parkingNumbers;
  @JsonKey(name: 'parking_category')
  final String? parkingCategory;
  @JsonKey(name: 'parking_image_url')
  final String? parkingImageUrl;
  final bool isSelected;

  ParkingBookingParkingConfigurationModel({
    this.id,
    this.resourceId,
    this.resourceType,
    this.noOfParkings,
    this.createdById,
    this.parkingNumbers,
    this.parkingCategory,
    this.parkingImageUrl,
    this.isSelected = false,
  });

  factory ParkingBookingParkingConfigurationModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingBookingParkingConfigurationModelFromJson(json);

  Map<String, dynamic> toJosn() =>
      _$ParkingBookingParkingConfigurationModelToJson(this);
}
