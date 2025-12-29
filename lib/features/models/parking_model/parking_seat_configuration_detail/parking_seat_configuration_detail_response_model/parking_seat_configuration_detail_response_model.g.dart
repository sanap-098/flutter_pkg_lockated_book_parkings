// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_seat_configuration_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSeatConfigurationDetailResponseModel
    _$ParkingSeatConfigurationDetailResponseModelFromJson(
            Map<String, dynamic> json) =>
        ParkingSeatConfigurationDetailResponseModel(
          seatConfigurations: (json['parking_configuration'] as List<dynamic>?)
              ?.map((e) => ParkingSeatConfigurationDetailModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$ParkingSeatConfigurationDetailResponseModelToJson(
        ParkingSeatConfigurationDetailResponseModel instance) =>
    <String, dynamic>{
      'parking_configuration': instance.seatConfigurations,
    };
