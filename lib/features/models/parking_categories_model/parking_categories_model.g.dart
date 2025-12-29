// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCategoriesModel _$ParkingCategoriesModelFromJson(
        Map<String, dynamic> json) =>
    ParkingCategoriesModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      active: json['active'] as bool?,
      resourceType: json['resource_type'] as String?,
      resourceId: (json['resource_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ParkingCategoriesModelToJson(
        ParkingCategoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'resource_type': instance.resourceType,
      'resource_id': instance.resourceId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image_url': instance.imageUrl,
    };
