// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_floor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingFloorModel _$ParkingBookingFloorModelFromJson(
        Map<String, dynamic> json) =>
    ParkingBookingFloorModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      availableParkings: (json['available_parkings'] as num?)?.toInt(),
      floorPlanAttachment: json['floor_plan_attachment'] as String?,
      configurationId: (json['configuration_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParkingBookingFloorModelToJson(
        ParkingBookingFloorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'available_parkings': instance.availableParkings,
      'floor_plan_attachment': instance.floorPlanAttachment,
      'configuration_id': instance.configurationId,
    };
