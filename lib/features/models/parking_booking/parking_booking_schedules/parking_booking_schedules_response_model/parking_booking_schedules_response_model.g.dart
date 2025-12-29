// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_schedules_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingSchedulesResponseModel
    _$ParkingBookingSchedulesResponseModelFromJson(Map<String, dynamic> json) =>
        ParkingBookingSchedulesResponseModel(
          parkingConfiguration: json['parking_configuration'] == null
              ? null
              : ParkingBookingSchedulesParkingConfigurationModel.fromJson(
                  json['parking_configuration'] as Map<String, dynamic>),
          slots: (json['slots'] as List<dynamic>?)
              ?.map((e) => ParkingBookingSchedulesSlotModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          bookedSlots: json['booked_slots'] as List<dynamic>?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'],
        );

Map<String, dynamic> _$ParkingBookingSchedulesResponseModelToJson(
        ParkingBookingSchedulesResponseModel instance) =>
    <String, dynamic>{
      'parking_configuration': instance.parkingConfiguration,
      'slots': instance.slots,
      'booked_slots': instance.bookedSlots,
      'code': instance.code,
      'message': instance.message,
    };
