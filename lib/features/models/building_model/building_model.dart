import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class BuildingModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  @JsonKey(name: 'has_wing')
  final bool? hasWing;
  @HiveField(3)
  @JsonKey(name: 'has_floor')
  final bool? hasFloor;
  @HiveField(4)
  @JsonKey(name: 'has_area')
  final bool? hasArea;
  @HiveField(5)
  @JsonKey(name: 'has_room')
  final bool? hasRoom;
  @HiveField(6)
  @JsonKey(name: 'available_seats')
  final dynamic availableSeats;
  @JsonKey(name: 'available_parkings')
  final dynamic availableParkings;

  @HiveField(7)
  bool isChecked;

  BuildingModel({
    this.id,
    this.name,
    this.hasWing,
    this.hasFloor,
    this.hasArea,
    this.hasRoom,
    this.availableSeats,
    this.availableParkings,
    this.isChecked = false,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);
}
