// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) => FloorModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      availableSeats: json['available_seats'],
      floorPlanAttachment: json['floor_plan_attachment'] as String?,
      availableParkings: (json['available_parkings'] as num?)?.toInt(),
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$FloorModelToJson(FloorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'available_seats': instance.availableSeats,
      'floor_plan_attachment': instance.floorPlanAttachment,
      'available_parkings': instance.availableParkings,
      'isChecked': instance.isChecked,
    };
