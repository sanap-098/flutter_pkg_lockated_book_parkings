// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_parking_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingParkingNumberModel _$ParkingBookingParkingNumberModelFromJson(
        Map<String, dynamic> json) =>
    ParkingBookingParkingNumberModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$ParkingBookingParkingNumberModelToJson(
        ParkingBookingParkingNumberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
    };
