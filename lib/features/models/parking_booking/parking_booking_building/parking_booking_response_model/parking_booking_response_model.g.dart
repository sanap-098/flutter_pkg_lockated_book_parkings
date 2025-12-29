// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingBuildingsResponseModel
    _$ParkingBookingBuildingsResponseModelFromJson(Map<String, dynamic> json) =>
        ParkingBookingBuildingsResponseModel(
          buildings: (json['buildings'] as List<dynamic>?)
              ?.map((e) => ParkingBookingBuildingModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          code: (json['code'] as num?)?.toInt(),
        );

Map<String, dynamic> _$ParkingBookingBuildingsResponseModelToJson(
        ParkingBookingBuildingsResponseModel instance) =>
    <String, dynamic>{
      'buildings': instance.buildings,
      'code': instance.code,
    };
