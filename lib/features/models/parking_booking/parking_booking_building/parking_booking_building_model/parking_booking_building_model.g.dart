// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingBuildingModel _$ParkingBookingBuildingModelFromJson(
        Map<String, dynamic> json) =>
    ParkingBookingBuildingModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hasWing: json['has_wing'] as bool?,
      hasFloor: json['has_floor'] as bool?,
      hasArea: json['has_area'] as bool?,
      hasRoom: json['has_room'] as bool?,
      floors: (json['floors'] as List<dynamic>?)
          ?.map((e) =>
              ParkingBookingFloorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableSeats: (json['available_seats'] as num?)?.toInt(),
      availableParkings: (json['available_parkings'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParkingBookingBuildingModelToJson(
        ParkingBookingBuildingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'has_wing': instance.hasWing,
      'has_floor': instance.hasFloor,
      'has_area': instance.hasArea,
      'has_room': instance.hasRoom,
      'floors': instance.floors,
      'available_seats': instance.availableSeats,
      'available_parkings': instance.availableParkings,
    };
