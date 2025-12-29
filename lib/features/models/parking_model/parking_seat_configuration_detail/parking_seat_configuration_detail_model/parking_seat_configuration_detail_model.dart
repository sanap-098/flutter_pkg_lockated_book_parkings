import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_number_model/parking_number_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_seat_configuration_detail_model.g.dart';

@HiveType(typeId: 12)
@JsonSerializable()
class ParkingSeatConfigurationDetailModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'resource_id')
  final int? resourceId;
  @HiveField(2)
  @JsonKey(name: 'resource_type')
  final String? resourceType;
  @HiveField(3)
  @JsonKey(name: 'no_of_parkings')
  final int? noOfParkings;
  @HiveField(4)
  @JsonKey(name: 'created_by_id')
  final int? createdById;
  @HiveField(5)
  @JsonKey(name: 'parking_numbers')
  final List<ParkingNumberModel>? parkingNumbers;
  @HiveField(6)
  @JsonKey(name: 'parking_category')
  final String? parkingCategory;
  @HiveField(7)
  @JsonKey(name: 'parking_image_url')
  final String? parkingImageUrl;

  ParkingSeatConfigurationDetailModel({
    this.id,
    this.resourceId,
    this.resourceType,
    this.noOfParkings,
    this.createdById,
    this.parkingNumbers,
    this.parkingCategory,
    this.parkingImageUrl,
  });

  factory ParkingSeatConfigurationDetailModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingSeatConfigurationDetailModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkingSeatConfigurationDetailModelToJson(this);
}
