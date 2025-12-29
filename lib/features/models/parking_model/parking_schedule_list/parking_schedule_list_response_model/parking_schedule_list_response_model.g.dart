// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_schedule_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingScheduleListResponseModel _$ParkingScheduleListResponseModelFromJson(
        Map<String, dynamic> json) =>
    ParkingScheduleListResponseModel(
      parkingConfiguration: json['parking_configuration'] == null
          ? null
          : ParkingSeatConfigurationModel.fromJson(
              json['parking_configuration'] as Map<String, dynamic>),
      slots: (json['slots'] as List<dynamic>?)
          ?.map((e) => ParkingSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookedSlots: (json['booked_slots'] as List<dynamic>?)
          ?.map((e) => ParkingSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num?)?.toInt(),
      message: json['message'],
    );

Map<String, dynamic> _$ParkingScheduleListResponseModelToJson(
        ParkingScheduleListResponseModel instance) =>
    <String, dynamic>{
      'parking_configuration': instance.parkingConfiguration,
      'slots': instance.slots,
      'booked_slots': instance.bookedSlots,
      'code': instance.code,
      'message': instance.message,
    };
