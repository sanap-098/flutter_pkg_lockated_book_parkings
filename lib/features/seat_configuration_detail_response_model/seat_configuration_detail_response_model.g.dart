// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_configuration_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatConfigurationDetailResponseModel
    _$SeatConfigurationDetailResponseModelFromJson(Map<String, dynamic> json) =>
        SeatConfigurationDetailResponseModel(
          seatConfigurations: (json['seat_configuration'] as List<dynamic>?)
              ?.map((e) => SeatConfigurationDetailModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$SeatConfigurationDetailResponseModelToJson(
        SeatConfigurationDetailResponseModel instance) =>
    <String, dynamic>{
      'seat_configuration': instance.seatConfigurations,
    };
