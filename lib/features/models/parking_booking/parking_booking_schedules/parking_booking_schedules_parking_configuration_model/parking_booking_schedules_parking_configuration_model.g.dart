// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_schedules_parking_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingSchedulesParkingConfigurationModel
    _$ParkingBookingSchedulesParkingConfigurationModelFromJson(
            Map<String, dynamic> json) =>
        ParkingBookingSchedulesParkingConfigurationModel(
          id: (json['id'] as num?)?.toInt(),
          buildingId: (json['building_id'] as num?)?.toInt(),
          floorId: (json['floor_id'] as num?)?.toInt(),
          parkingCategory: json['parking_category'] as String?,
          totalParkings: (json['total_parkings'] as num?)?.toInt(),
          availableParkings: (json['available_parkings'] as num?)?.toInt(),
          bookedParkings: (json['booked_parkings'] as num?)?.toInt(),
        );

Map<String, dynamic> _$ParkingBookingSchedulesParkingConfigurationModelToJson(
        ParkingBookingSchedulesParkingConfigurationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'building_id': instance.buildingId,
      'floor_id': instance.floorId,
      'parking_category': instance.parkingCategory,
      'total_parkings': instance.totalParkings,
      'available_parkings': instance.availableParkings,
      'booked_parkings': instance.bookedParkings,
    };
