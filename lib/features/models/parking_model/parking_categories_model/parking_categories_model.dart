import 'package:json_annotation/json_annotation.dart';

part 'parking_categories_model.g.dart';

@JsonSerializable()
class ParkingCategoriesModel {
  ParkingCategoriesModel({
    required this.id,
    required this.name,
    required this.active,
    required this.resourceType,
    required this.resourceId,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  final int? id;
  final String? name;
  final bool? active;

  @JsonKey(name: 'resource_type')
  final String? resourceType;

  @JsonKey(name: 'resource_id')
  final int? resourceId;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  factory ParkingCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingCategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingCategoriesModelToJson(this);
}
