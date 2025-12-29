import 'package:json_annotation/json_annotation.dart';

part 'floor_model.g.dart';

@JsonSerializable()
class FloorModel {
  int? id;
  String? name;
  @JsonKey(name: 'available_seats')
  final dynamic availableSeats;
  @JsonKey(name: 'floor_plan_attachment')
  final String? floorPlanAttachment;
  @JsonKey(name: 'available_parkings')
  final int? availableParkings;
  bool isChecked;

  FloorModel({
    this.id,
    this.name,
    this.availableSeats,
    this.floorPlanAttachment,
    this.availableParkings,
    this.isChecked = false,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);

  Map<String, dynamic> toJson() => _$FloorModelToJson(this);
}
