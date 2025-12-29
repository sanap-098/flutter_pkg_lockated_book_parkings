// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_bookings_show_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingsShowScheduleModel _$ParkingBookingsShowScheduleModelFromJson(
        Map<String, dynamic> json) =>
    ParkingBookingsShowScheduleModel(
      slotId: json['slot_id'],
      slot: json['slot'] as String?,
      parkingNumber: json['parking_number'] as String?,
    );

Map<String, dynamic> _$ParkingBookingsShowScheduleModelToJson(
        ParkingBookingsShowScheduleModel instance) =>
    <String, dynamic>{
      'slot_id': instance.slotId,
      'slot': instance.slot,
      'parking_number': instance.parkingNumber,
    };
