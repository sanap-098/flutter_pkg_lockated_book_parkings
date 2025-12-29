import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_configuration_model.g.dart';

@HiveType(typeId: 7)
@JsonSerializable()
class SeatConfigurationModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'building_id')
  final int? buildingId;
  @HiveField(2)
  @JsonKey(name: 'wing_id')
  final int? wingId;
  @HiveField(3)
  @JsonKey(name: 'area_id')
  final int? areaId;
  @HiveField(4)
  @JsonKey(name: 'floor_id')
  final int? floorId;
  @HiveField(5)
  @JsonKey(name: 'seat_category')
  final String? seatCategory;
  @HiveField(6)
  @JsonKey(name: 'total_seats')
  final int? totalSeats;
  @HiveField(7)
  @JsonKey(name: 'available_seats')
  final int? availableSeats;
  @HiveField(8)
  @JsonKey(name: 'booked_seats')
  final int? bookedSeats;

  SeatConfigurationModel({
    this.id,
    this.buildingId,
    this.wingId,
    this.areaId,
    this.floorId,
    this.seatCategory,
    this.totalSeats,
    this.availableSeats,
    this.bookedSeats,
  });

  factory SeatConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$SeatConfigurationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatConfigurationModelToJson(this);
}
