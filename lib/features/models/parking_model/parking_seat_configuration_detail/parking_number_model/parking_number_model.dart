import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_number_model.g.dart';

@HiveType(typeId: 13)
@JsonSerializable()
class ParkingNumberModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final bool? active;
  bool isSelected;

  ParkingNumberModel({
    this.id,
    this.name,
    this.active,
    this.isSelected = false,
  });

  factory ParkingNumberModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingNumberModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingNumberModelToJson(this);
}
