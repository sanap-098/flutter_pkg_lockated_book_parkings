// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingCategoriesResponseModel
    _$ParkingBookingCategoriesResponseModelFromJson(
            Map<String, dynamic> json) =>
        ParkingBookingCategoriesResponseModel(
          parkingConfiguration:
              (json['parking_configuration'] as List<dynamic>?)
                  ?.map((e) => ParkingBookingParkingConfigurationModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
          code: (json['code'] as num?)?.toInt(),
        );

Map<String, dynamic> _$ParkingBookingCategoriesResponseModelToJson(
        ParkingBookingCategoriesResponseModel instance) =>
    <String, dynamic>{
      'parking_configuration': instance.parkingConfiguration,
      'code': instance.code,
    };
