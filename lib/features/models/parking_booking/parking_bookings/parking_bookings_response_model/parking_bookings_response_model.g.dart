// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_bookings_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingsResponseModel _$ParkingBookingsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ParkingBookingsResponseModel(
      parkingBookings: (json['parking_bookings'] as List<dynamic>?)
          ?.map((e) => ParkingBookingsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParkingBookingsResponseModelToJson(
        ParkingBookingsResponseModel instance) =>
    <String, dynamic>{
      'parking_bookings': instance.parkingBookings,
      'code': instance.code,
    };
