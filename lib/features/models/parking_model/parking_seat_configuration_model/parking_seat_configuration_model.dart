import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_seat_configuration_model.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class ParkingSeatConfigurationModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'building_id')
  final int? buildingId;
  // @HiveField(2)
  // @JsonKey(name: 'wing_id')
  // final int? wingId;
  // @HiveField(3)
  // @JsonKey(name: 'area_id')
  // final int? areaId;
  @HiveField(2)
  @JsonKey(name: 'floor_id')
  final int? floorId;
  @HiveField(3)
  @JsonKey(name: 'parking_category')
  final String? parkingCategory;
  @HiveField(4)
  @JsonKey(name: 'total_parkings')
  final int? totalParkings;
  @HiveField(5)
  @JsonKey(name: 'available_parkings')
  final int? availableParkings;
  @HiveField(6)
  @JsonKey(name: 'booked_parkings')
  final int? bookedParkings;

  ParkingSeatConfigurationModel({
    this.id,
    this.buildingId,
    // this.wingId,
    // this.areaId,
    this.floorId,
    this.parkingCategory,
    this.totalParkings,
    this.availableParkings,
    this.bookedParkings,
  });

  factory ParkingSeatConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingSeatConfigurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingSeatConfigurationModelToJson(this);
}
